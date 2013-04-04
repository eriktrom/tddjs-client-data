do ->
  ajax = tddjs.ajax

  module "Get Request",
    setup: -> @ajaxCreate = ajax.create
    teardown: -> ajax.create = @ajaxCreate

  test "it should define get method", ->
    ok(typeof ajax.get is "function")

  test "it should throw error without url", ->
    throws ->
      ajax.get()
    , TypeError

  test "it should obtain an XMLHttpRequest object", ->
    openStub = stubFn(open: ->)
    ajax.create = openStub

    ajax.get("/url")

    ok(ajax.create.called)

  test "it should call open with method, url, async flag", ->
    openStub = stubFn()

    ajax.create = stubFn(open: openStub)

    url = "/url"
    ajax.get(url)

    # actual = Array::slice.call(actual)
    deepEqual(openStub.args, ["GET", url, true])
