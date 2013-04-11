do ->
  ajax = tddjs.ajax

  module "Get Request",
    setup: ->
      @ajaxCreate = ajax.create
      @xhr = Object.create(fakeXMLHttpRequest)
      ajax.create = stubFn(@xhr)
    teardown: -> ajax.create = @ajaxCreate

  test "it should define get method", ->
    ok(typeof ajax.get is "function")

  test "it should throw error without url", ->
    throws ->
      ajax.get()
    , TypeError

  test "it should obtain an XMLHttpRequest object", ->
    ajax.get("/url")

    ok(ajax.create.called)

  test "it should call open with method, url, async flag", ->
    ajax.get("/url")

    deepEqual(@xhr.open.args, ["GET", "/url", true])

  test "it should add onreadystatechange handler", ->
    ajax.get("/url")

    ok(typeof @xhr.onreadystatechange is "function")

  test "it should call send", ->
    ajax.get("/url")

    ok(@xhr.send.called)