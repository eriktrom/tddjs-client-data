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

  # How will we issue requests periodically? A simple solution would be to make
  # the request through setInterval. But, this may cause problems. Issuing new
  # requests without knowing whether the previous request completed could lead
  # to multiple simultaneous connections(bad). To fix this, we would need to wrap
  # the success and failure callbacks
  #
  # Instead of defining identical success and failure callbacks, let's add a
  # a complete callback to tddjs.ajax.request. It will be called when a request
  # is complete, regardless of success. To do this, we'll need to update the
  # forceWithReadyStateAndStatus helper, and add 3 tests asserting that the
  # complete callback is called for successful, failed and local requests


#   test "should schedule new request when complete", ->
#     poller = Object.create(ajax.poller)
#     poller.url = "/url"

#     poller.start()
#     @xhrDbl.complete()
#     @xhrDbl.send = stubFn()
#     Clock.tick(1000)
#      
#     ok @xhrDbl.send.called


do ->
  # Stubbing timers, pg 303
  # module "Stubbing setTimeout",
  #   setup: -> @setTimeout = window.setTimeout
  #   teardown: -> window.setTimeout = @setTimeout

  # test "timer example", 0, ->
  #   window.setTimeout = stubFn()
  #   ok window.setTimeout.called

