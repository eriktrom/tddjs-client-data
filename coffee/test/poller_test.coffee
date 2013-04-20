do ->
  ajax = tddjs.ajax
  matchers = tddjs.util.matchers

  module "Poller Test"

  test "it should be an object", ->
    ok matchers.okObject(ajax.poller)

  test "it throws an exception for missing URL", ->
    poller = Object.create(ajax.poller)
    raises ->
      poller.start()
    , TypeError

  test "it should define a start method", ->
    ok matchers.okFunction(ajax.poller.start)