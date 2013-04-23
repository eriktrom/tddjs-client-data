do ->
  ajax = tddjs.ajax
  matchers = tddjs.util.matchers

  setup = ->
    @originalAjaxCreate = ajax.create
    @originalAjaxRequest = ajax.request
    @xhrDbl = Object.create(XMLHttpRequestDbl) # why do we need Object.create? Chpt. 7?
    ajax.create = stubFn(@xhrDbl)
    @poller = Object.create(ajax.poller)
    @poller.url = "/url"
    @clock = sinon.useFakeTimers()
  teardown = ->
    ajax.create = @originalAjaxCreate
    ajax.request = @originalAjaxRequest
    @clock.restore

  module "Poller", {setup, teardown}

  test "it should be an object", ->
    ok matchers.okObject(ajax.poller)

  test "it should define a start method", ->
    ok matchers.okFunction(ajax.poller.start)

  test "#start throws an exception when called without a URL", ->
    @poller.url = null
    raises ->
      @poller.start()
    , TypeError
  # to specify that the start method should start polling, we need to assert
  # somehow that a URL made it across to the XMLHttpRequest object
  # - we have a choice here. we could stub ajax.request or ajax.create. Previously,
  # we stubbed ajax.create while we were driving out ajax.request. b/c we can now
  # depend on ajax.request, we can just stub that here. Yes, this makes the test
  # a bit more like an integration test, however, it still fulfills the role of
  # dependency injection, pg 298,299(326 in preview)
  test "#start opens an XHR request to a URL", ->
    @poller.start()
    ok @xhrDbl.open.called

  # knowing that the open method was called on transport doesn't necessarily
  # mean that the request was sent. Let's check that send was called as well
  test "#start sends an XHR request to a URL", ->
    @poller.start()
    ok @xhrDbl.send.called


  # Note regarding second stub in following test:
  # ajax.request used by the poller creates a new XMLHttpRequest object on
  # each request, so how can we expect that simply redefining the send method
  # on the fake instance will work?
  #
  # The trick is that the ajax.create stub will be called once for each request
  # but it always returns the same instance within a single test
  #
  # In order for this test to succeed, the poller needs to fire a new request
  # asynchronously after the original request finished
  test "#start schedules a new request when complete", ->
    @poller.start()
    @xhrDbl.complete()
    @xhrDbl.send = stubFn() # see note above test
    @clock.tick(1000)
     
    ok @xhrDbl.send.called

  test "#start configures exact request interval(no less, no more)", ->
    # rare case where we assert, do more stuff, then assert again
    @poller.interval = 350
    @poller.start()
    @xhrDbl.complete()
    @xhrDbl.send = stubFn()

    @clock.tick(349)
    ok !(@xhrDbl.send.called)

    @clock.tick(1)
    ok @xhrDbl.send.called

  test "#start should pass headers to request", ->
    @poller.headers =
      "Header-One": "1"
      "Header-Two": "2"

    @poller.start()

    strictEqual @xhrDbl.headers["Header-One"], @poller.headers["Header-One"]
    strictEqual @xhrDbl.headers["Header-Two"], @poller.headers["Header-Two"]

  test "#start should pass success callback", ->
    @poller.success = stubFn()

    @poller.start()
    @xhrDbl.complete() # simulate successful request

    ok @poller.success.called

  test "#start should pass failure callback", ->
    @poller.failure = stubFn()

    @poller.start()
    @xhrDbl.complete(400)

    ok @poller.failure.called

  test "complete callback can be used by clients as well", ->
    @poller.complete = stubFn()

    @poller.start()
    @xhrDbl.complete()

    ok @poller.complete.called

  # TODO: improve poller to handle things like network issues, suggested as
  # exercise to the reader, pg 311

  test '''new requests should be made immediatly if the minimum interval has
          passed since the last request was issued''', ->
    @poller.interval = 500
    @poller.start()
    ahead = new Date().getTime() + 600
    stubDateConstructor(new Date(ahead))
    ajax.request = stubFn()

    @xhrDbl.complete()
    @clock.tick(0) # touch the clock to fire queded timers

    ok ajax.request.called

  test "add cache buster to URL", ->
    date = new Date()
    timeStamp = date.getTime()
    stubDateConstructor(date)
    @poller.url = "/url"

    @poller.start()

    strictEqual @xhrDbl.open.args[1], "/url?#{timeStamp}"

do ->
  ajax = tddjs.ajax

  module "Poll API",
    setup: ->
      @request = ajax.request
      @create = Object.create
      ajax.request = stubFn()
    teardown: ->
      ajax.request = @request
      Object.create = @create

  test "it should call start on poller object", ->
    # an object inheriting from ajax.poller is created using Object.create
    # and its start method is called
    poller = {start: stubFn()}
    Object.create = stubFn(poller)

    ajax.poll("/url")

    ok poller.start.called

  test "it should set the url property on the poller object", ->
    poller = ajax.poll("/url")
    strictEqual poller.url, "/url"

  test "it should set the headers on the poller", ->
    headersDbl = {"Header-One": "1"}
    poller = ajax.poll("/url", {headers: headersDbl})
    strictEqual poller.headers, headersDbl

  test "it sets the success callback on the poller", ->
    successDbl = stubFn()
    poller = ajax.poll("/url", {success: successDbl})
    strictEqual poller.success, successDbl

  test "it sets the failure callback on the poller", ->
    failureDbl = stubFn()
    poller = ajax.poll("/url", {failure: failureDbl})
    strictEqual poller.failure, failureDbl

  test "it sets the complete callback on the poller", ->
    completeDbl = 200
    poller = ajax.poll("/url", {complete: completeDbl})
    strictEqual poller.complete, completeDbl

  test "it sets the interval on the poller", ->
    intervalDbl = 200
    poller = ajax.poll("/url", {interval: intervalDbl})
    strictEqual poller.interval, intervalDbl