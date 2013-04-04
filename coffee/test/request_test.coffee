module "Get Request"

test "it should define get method", ->
  ok(typeof tddjs.ajax.get is "function")