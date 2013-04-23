do ->
  ajax = tddjs.ajax

  module "Comet Client"

  test "it should be an object", ->
    ok typeof ajax.cometClient is "object"