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
    ajax.create = stubFn(open: ->)

    ajax.get("/url")

    ok(ajax.create.called)

  test "it should call open with method, url, async flag", ->
    actual = "hello"

    ajax.create = stubFn(
      open: ->
        actual = arguments
    )

    url = "/url"
    ajax.get(url)

    actual = Array::slice.call(actual)
    deepEqual(actual, ["GET", url, true])
