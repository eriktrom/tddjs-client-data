do ->
  ajax = tddjs.ajax

  module "Comet Client"

  test "it should be an object", ->
    ok typeof ajax.cometClient is "object"

  test "it should have dispatch method", ->
    client = Object.create(ajax.cometClient)
    ok typeof client.dispatch is "function"
