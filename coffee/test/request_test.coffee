do ->
  matchers = tddjs.namespace("util").matchers
  ajax = tddjs.ajax

  setup = ->
    @ajaxCreate = ajax.create
    @xhrDbl = Object.create(XMLHttpRequestDbl) # why do we need Object.create? Chpt. 7?
    ajax.create = stubFn(@xhrDbl)
  teardown = -> ajax.create = @ajaxCreate

  do ->
    module "Get Request", {setup, teardown}

    test "@xhrDbl is a function", ->
      ok( matchers.okFunction(ajax.create) )

    test "it should define get method", ->
      ok( matchers.okFunction(ajax.get) ) # hmmm.... TODO - make real matcher
      ok( typeof ajax.get is "function" ) # <-- any accuracy difference vs ^^

    test "it should call open with method, url, async flag", ->
      ajax.get("/url")
      deepEqual(@xhrDbl.open.args, ["GET", "/url", true])

  do ->
    ###*
     * A test helper to force the value of a the status and ready state
     * @param  {Object} xhr        a fake xhr object
     * @param  {Number} status     a fake http status code (e.g. 200)
     * @param  {Number} readyState a fake xhr ready state (e.g. 4)
     * @return {Object}            returns an object with properties successIsCalled
     *                                     and failureIsCalled, used for indicating if the
     *                                     corresponding callback was called
    ###
    forceStatusAndReadyState = (xhr, status, readyState) ->
      success = stubFn()
      failure = stubFn()
      ajax.request "/url", success: success, failure: failure
      xhr.status = status
      xhr.readyStateChange(readyState)

      successIsCalled: success.called
      failureIsCalled: failure.called

    module "Ready State Handler", {setup, teardown}

    test "it should call success handler for status 200", 1, ->
      request = forceStatusAndReadyState(@xhrDbl, 200, 4)
      ok(request.successIsCalled)

    test "it should not throw error without success handler", ->
      @xhrDbl.readyState = 4
      @xhrDbl.status = 200

      ajax.request("/url")

      # 3 ways to test for assertNoException, one js, two CS
      # 1 - this is what we want to come out
      `
      (function () {
        this.xhrDbl.onreadystatechange();
      }.bind(this))();
      `
      # 2 - this is nice, but adds noise to the js output, although maybe it is idiomatic?
      do => @xhrDbl.onreadystatechange()
      # 3 - this is how to do it on an open source project where js is commited
      # - actually, maybe not, maybe number 2 is best? check the books TODO
      do (-> @xhrDbl.onreadystatechange()).bind(@)

      ok(true)
      expect 1
    test "it should pass null as argument to send", ->
      ajax.request("/url")
      ok(@xhrDbl.send.args[0] is null)

    test "it should reset onreadystatechange when complete", ->
      @xhrDbl.readyState = 4
      ajax.request("/url")

      @xhrDbl.onreadystatechange()

      ok(@xhrDbl.onreadystatechange is tddjs.noop)

    test "calls success handler for local requests (instead of failing silently)", ->
      tddjs.isLocal = stubFn(true)
      request = forceStatusAndReadyState(@xhrDbl, 0, 4)

      ok(request.successIsCalled)

  do ->
    module "Request", {setup, teardown}

    test "it should use specified request method", ->
      ajax.request "/uri", method: "POST"
      strictEqual(@xhrDbl.open.args[0], "POST")

    test "it should throw error without url", ->
      throws ->
        ajax.request()
      , TypeError

    test "it should obtain an XMLHttpRequest object", ->
      ajax.request("/url")
      ok(ajax.create.called)

    test "it should add onreadystatechange handler", ->
      ajax.request("/url")
      ok(typeof @xhrDbl.onreadystatechange is "function")

    test "it should call send", ->
      ajax.request("/url")
      ok(@xhrDbl.send.called)

  do ->
    module "Post Request",
      setup: -> @ajaxRequest = ajax.request
      teardown: -> ajax.request = @ajaxRequest

    test "it should call request with POST method", ->
      ajax.request = stubFn()
      ajax.post("/url")
      strictEqual(ajax.request.args[1].method, "POST")