do ->
  ajax = tddjs.ajax
  matchers = tddjs.util.matchers

  setup = ->
    @orignalAjaxCreate = ajax.create
    @xhrDbl = Object.create(XMLHttpRequestDbl) # why do we need Object.create? Chpt. 7?
    ajax.create = stubFn(@xhrDbl)
  teardown = ->
    ajax.create = @orignalAjaxCreate

  module "Poller Test", {setup, teardown}

  test "it should be an object", ->
    ok matchers.okObject(ajax.poller)

  # test "it throws an exception for missing URL", ->
  #   poller = Object.create(ajax.poller)
  #   raises ->
  #     poller.start()
  #   , TypeError

  # test "it should define a start method", ->
  #   ok matchers.okFunction(ajax.poller.start)

  # test "opens XHR request to URL", ->
  #   poller = Object.create(ajax.poller)
  #   poller.url = "/url"

  #   poller.start()

  #   ok(@xhrDbl.open.called)
  #   strictEqual(@xhrDbl.open.args[1], poller.url)

  # # knowing that the open method was called on transport doesn't necessarily
  # # mean that the request was sent. Let's check that as well
  # test "sends XHR request to URL", ->
  #   poller = Object.create(ajax.poller)
  #   poller.url = "/url"

  #   poller.start()

  #   expectedArgs = ["GET", poller.url, true]
  #   # actualArgs = [].slice.call(@xhrDbl.open.args)
  #   actualArgs = @xhrDbl.open.args # I already applied the above in my source code

  #   ok @xhrDbl.open.called
  #   deepEqual(actualArgs, expectedArgs)
  #   ok @xhrDbl.send.called

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

