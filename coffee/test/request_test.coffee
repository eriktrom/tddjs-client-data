module "Get Request"

test "it should define get method", ->
  ok(typeof tddjs.ajax.get is "function")

test "it should throw error without url", ->
  throws ->
    tddjs.ajax.get()
  , TypeError