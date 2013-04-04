do ->
  ajax = tddjs.ajax

  module "Get Request"

  test "it should define get method", ->
    ok(typeof ajax.get is "function")

  test "it should throw error without url", ->
    throws ->
      ajax.get()
    , TypeError