do ->
  ajax = tddjs.ajax

  module "Comet Client"

  test "it should be an object", ->
    ok typeof ajax.cometClient is "object"

  module "cometClient#dispatch",
    setup: ->
      @client = @observable = Object.create(ajax.cometClient)
      @observable.observers = {notify: stubFn()}

  # it plays the role of an observable

  test "it is a function", ->
    ok typeof @observable.dispatch is "function"

  test "it should notify observers", ->
    # expect dispatch to call notify on the observable observers object,
    @observable.dispatch {someEvent: [{id: 1234}]}

    args = @observable.observers.notify.args

    ok @observable.observers.notify.called
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
    @observable.observers = null

    do (-> @observable.dispatch(someEvent: [{}])).bind(@)

    ok true
    expect 1

  test "should not throw if notify is undefined", ->
    @observable.observers = {}

    do (-> @observable.dispatch(someEvent: [{}])).bind(@)
    ok true
    expect 1

  test "should not throw if data is not provided", ->
    do (-> @observable.dispatch()).bind(@)
    ok true
    expect 1

  test "should not throw if event is null", ->
    do (-> @observable.dispatch(myEvent: null)).bind(@)
    ok true
    expect 1

do ->
  ajax = tddjs.ajax
  module "cometClient#observe",
    setup: ->
      @observable = Object.create(ajax.cometClient)

  test "should remember observers", ->
    observer1 = stubFn()
    observer2 = stubFn()
    @observable.observe("myEvent", observer1)
    @observable.observe("myEvent", observer2)
    data = { myEvent: [{}]}

    @observable.dispatch(data)

    ok observer1.called
    strictEqual observer1.args[0], data.myEvent[0]

    ok observer2.called
    strictEqual observer2.args[0], data.myEvent[0]
