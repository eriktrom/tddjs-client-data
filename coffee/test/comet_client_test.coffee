do ->
  ajax = tddjs.ajax

  module "Comet Client"

  test "it should be an object", ->
    ok typeof ajax.cometClient is "object"

  module "cometClient#dispatch",
    setup: ->
      @client = Object.create(ajax.cometClient)
      @client.observers = {notify: stubFn()}

  test "is a function", ->
    ok typeof @client.dispatch is "function"

  test "should notify observers", ->
    # expect dispatch to call notify on the observable observers object
    @client.dispatch {someEvent: [{id: 1234}]}

    args = @client.observers.notify.args

    ok @client.observers.notify.called
    strictEqual args[0], "someEvent"
    deepEqual args[1], {id: 1234}

  # TODO: the next 2 tests were left as an exercise to the reader, pg 327

  # test "notify should be called for all topics in data", ->
  #   data =
  #     topicOne: [{isFun: true}]
  #     topicTwo: [{isHard: true}]

  # test "all events are passed to observers of a topic", ->
  #   data =
  #     topicOne: [{isFun: true}, {isBoring: false}]

  #   @client.dispatch(data)

  #   deepEqual @client.observers.notify.args, []

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

  test "should not throw if data is not provided", ->
    do (-> @client.dispatch()).bind(@)
    ok true
    expect 1

  test "should not throw if event is null", ->
    do (-> @client.dispatch(myEvent: null)).bind(@)
    ok true
    expect 1