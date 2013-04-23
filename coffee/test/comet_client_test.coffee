do ->
  ajax = tddjs.ajax

  module "Comet Client"

  test "it should be an object", ->
    ok typeof ajax.cometClient is "object"

  module "cometClient#dispatch",
    setup: ->
      @client = Object.create(ajax.cometClient)
      @client.observers = {notify: stubFn()}

  # it plays the role of an observable

  test "it is a function", ->
    ok typeof @client.dispatch is "function"

  test "it should notify observers", ->
    # expect dispatch to call notify on the observable observers object,
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

do ->
  ajax = tddjs.ajax
  module "cometClient#observe",
    setup: ->
      @client = Object.create(ajax.cometClient)

  test "should remember observers", ->
    observer1 = stubFn()
    observer2 = stubFn()
    @client.observe("myEvent", observer1)
    @client.observe("myEvent", observer2)
    data = { myEvent: [{}]}

    @client.dispatch(data)

    ok observer1.called
    strictEqual observer1.args[0], data.myEvent[0]

    ok observer2.called
    strictEqual observer2.args[0], data.myEvent[0]

do ->
  ajax = tddjs.ajax
  module "cometClient#connect",
    setup: ->
      @ajaxPoll = ajax.poll
      @ajaxCreate = ajax.create
      @client = Object.create(ajax.cometClient)
      @xhrDbl = Object.create(XMLHttpRequestDbl)
      ajax.create = stubFn(@xhrDbl)

    teardown: ->
      ajax.poll = @ajaxPoll
      ajax.create = @ajaxCreate

  test "it should start polling", ->
    @client.url = "/my/url"
    ajax.poll = stubFn()

    @client.connect()

    ok ajax.poll.called
    strictEqual ajax.poll.args[0], "/my/url"

  test "it will only allow one polling connection at a time", ->
    @client.url = "/my/url"
    ajax.poll1 = stubFn()
    @client.connect()
    ajax.poll2 = stubFn()

    @client.connect()

    ok not ajax.poll2.called

  test "it will throw an error is no url exists", ->
    ajax.poll = stubFn()

    raises =>
      @client.connect()
    , TypeError

  test "it will dispatch data from request", ->
    data =
      topic: [id: 1234]
      otherTopic: [name: "Me"]
    @client.url = "/my/url"
    @client.dispatch = stubFn()

    @client.connect()
    @xhrDbl.complete(200, JSON.stringify(data))

    ok @client.dispatch.called
    deepEqual @client.dispatch.args[0], data