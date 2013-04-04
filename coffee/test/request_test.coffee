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
    ajax.create = stubFn()

    ajax.get("/url")

    ok(ajax.create.called)