do ->
  matchers = tddjs.namespace("util").matchers
  ajax = tddjs.ajax

  do ->
    module "Get Request",
      setup: ->
        @ajaxCreate = ajax.create
        @xhrDbl = Object.create(XMLHttpRequestDbl)
        ajax.create = stubFn(@xhrDbl)
      teardown: -> ajax.create = @ajaxCreate

    test "@xhrDbl is a function", ->
      ok( matchers.okFunction(ajax.create) )

    test "it should define get method", ->
      ok( matchers.okFunction(ajax.get) ) # hmmm.... TODO - make real matcher
      ok( typeof ajax.get is "function" ) # <-- any accuracy difference vs ^^

    test "it should throw error without url", ->
      throws ->
        ajax.get()
      , TypeError

    test "it should obtain an XMLHttpRequest object", ->
      ajax.get("/url")
      ok(ajax.create.called)

    test "it should call open with method, url, async flag", ->
      ajax.get("/url")
      deepEqual(@xhrDbl.open.args, ["GET", "/url", true])

    test "it should add onreadystatechange handler", ->
      ajax.get("/url")
      ok(typeof @xhrDbl.onreadystatechange is "function")

    test "it should call send", ->
      ajax.get("/url")
      ok(@xhrDbl.send.called)

  do ->
    module "Ready State Handler",
      setup: ->
        @ajaxCreate = ajax.create
        @xhrDbl = Object.create(XMLHttpRequestDbl) # why do we need Object.create? Chpt. 7?
        ajax.create = stubFn(@xhrDbl)
      teardown: -> ajax.create = @ajaxCreate

    test "it should call success handler for status 200", 1, ->
      @xhrDbl.readyState = 4
      @xhrDbl.status = 200
      success = stubFn()

      ajax.get("/url", {success})
      @xhrDbl.onreadystatechange()

      ok(success.called)

    test "it should not throw error without success handler", ->
      @xhrDbl.readyState = 4
      @xhrDbl.status = 200

      ajax.get("/url")

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