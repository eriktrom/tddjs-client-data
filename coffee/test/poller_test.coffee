do ->
  ajax = tddjs.ajax
  matchers = tddjs.util.matchers

  setup = ->
    @orignalAjaxCreate = ajax.create
    @xhrDbl = Object.create(XMLHttpRequestDbl) # why do we need Object.create? Chpt. 7?
    ajax.create = stubFn(@xhrDbl)
  teardown = ->
    ajax.create = @orignalAjaxCreate

  module "Poller", {setup, teardown}

  test "it should be an object", ->
    ok matchers.okObject(ajax.poller)

  test "it should define a start method", ->
    ok matchers.okFunction(ajax.poller.start)

  module "Poller#start", {setup, teardown}

  test "it throws an exception when called without a URL", ->
    poller = Object.create(ajax.poller)
    raises ->
      poller.start()
    , TypeError
  # to specify that the start method should start polling, we need to assert
  # somehow that a URL made it across to the XMLHttpRequest object
  # - we have a choice here. we could stub ajax.request or ajax.create. Previously,
  # we stubbed ajax.create while we were driving out ajax.request. b/c we can now
  # depend on ajax.request, we can just stub that here. Yes, this makes the test
  # a bit more like an integration test, however, it still fulfills the role of
  # dependency injection, pg 298,299(326 in preview)
  test "it opens an XHR request to a URL", ->
    poller = Object.create(ajax.poller)
    poller.url = "/url"

    poller.start()

    ok @xhrDbl.open.called
    deepEqual(@xhrDbl.open.args, ["GET", poller.url, true])

  # knowing that the open method was called on transport doesn't necessarily
  # mean that the request was sent. Let's check that send was called as well
  test "it sends an XHR request to a URL", ->
    poller = Object.create(ajax.poller)
    poller.url = "/url"

    poller.start()

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
  test "should schedule new request when complete", ->
    @clock = sinon.useFakeTimers()

    poller = Object.create(ajax.poller)
    poller.url = "/url"

    poller.start()
    @xhrDbl.complete()
    @xhrDbl.send = stubFn() # see note above test
    @clock.tick(1000)
     
    ok @xhrDbl.send.called

    @clock.restore
    # TODO: put this in teardown or call it in try/catch/ensure

# do ->
  # Stubbing timers, pg 303
  # jsUnitMockTimeout provides a Clock object and overrides the native
  # setTimeout, setInterval, clearTimeout, clearInterval functions.
  #
  # When Clock.tick(ms) is called, any function scheduled to run sometime
  # within the next ms number of milliseconds will be called. This allows the
  # test to effectively fast-forward time and verify that certain functions
  # were called when scheduled to
  #
  # Contrast this to using a normal stub - where we would stub the timer, do
  # some work and then assert that the stub was used as expected. Stubbing yields
  # shorter tests, but using the clock yields more communicative tests. Take note
  # as we get a feel for the differences between the two approaches.

  # module "Stubbing setTimeout",
  #   setup: -> @setTimeout = window.setTimeout
  #   teardown: -> window.setTimeout = @setTimeout

  # test "timer example", ->
  #   window.setTimeout = stubFn()
  #   ok window.setTimeout.called

