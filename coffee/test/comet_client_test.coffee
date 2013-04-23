do ->
  ajax = tddjs.ajax

  module "Comet Client"

  test "it should be an object", ->
    ok typeof ajax.cometClient is "object"

  module "cometClient#dispatch",
    setup: -> @client = Object.create(ajax.cometClient)

  test "it should have dispatch method", ->
    ok typeof @client.dispatch is "function"

  test "#dispatch should notify observers", ->
    # expect dispatch to call notify on the observable observers object
    @client.observers = {notify: stubFn()}

    @client.dispatch {someEvent: [{id: 1234}]}

    args = @client.observers.notify.args

    ok @client.observers.notify.called
    strictEqual args[0], "someEvent"
    deepEqual args[1], {id: 1234}

  test "should not throw if no observers", ->
    @client.observers = null

    do (-> @client.dispatch(someEvent: [{}])).bind(@)

    ok true
    expect 1

  test "should not throw if notify is undefined", ->
    @client.observers = {}

    do (-> @client.dispatch(someEvent: [{}])).bind(@)
    ok true
    expect 1