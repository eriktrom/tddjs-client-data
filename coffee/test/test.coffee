module "Observable#observe",
  setup: ->
    @observable = Object.create(tddjs.util.observable)

test "it adds observers", ->
  observers = [(->), (->)]

  @observable.observe("event", observers[0])
  @observable.observe("event", observers[1])

  # deepEqual(@observable.observers, observers)

  # this was his refactoring, it looks like coupling to me - what if we
  # move or change hasObserver? this will fail and we'll have to fix it
  ok(@observable.hasObserver("event", observers[0]))
  ok(@observable.hasObserver("event", observers[1]))




module "Observable#hasObserver",
  setup: ->
    @observable = Object.create(tddjs.util.observable)

test "it returns true when it has observer(s)", ->
  observer = ->

  @observable.observe("event", observer)

  ok(@observable.hasObserver("event", observer))

test "it returns false when it has no observer(s)", ->
  ok !(@observable.hasObserver("event", ->))




module "Observable#notify",
  setup: ->
    @observable = Object.create(tddjs.util.observable)

test "it calls all observers", ->
  observer1 = -> observer1.called = true
  observer2 = -> observer2.called = true

  @observable.observe("event", observer1)
  @observable.observe("event", observer2)
  @observable.notify("event")

  ok(observer1.called)
  ok(observer2.called)

test "it should pass through arguments", ->
  actual = null

  @observable.observe "event", -> actual = arguments

  @observable.notify("event", "String", 1, 32)

  deepEqual(Array::slice.call(actual, 0), ["String", 1, 32])

test "it should throw for uncallable observer", ->
  throws ->
    @observable.observe("event", {})
  , TypeError

test "it should notify all even when some fail", ->
  observer1 = -> throw new Error("Oops")
  observer2 = -> observer2.called = true

  @observable.observe("event", observer1)
  @observable.observe("event", observer2)
  @observable.notify("event")

  ok(observer2.called)

test "it should call observers in the order they were added", ->
  calls = []
  observer1 = -> calls.push(observer1)
  observer2 = -> calls.push(observer2)

  @observable.observe("event", observer1)
  @observable.observe("event", observer2)
  @observable.notify("event")

  ok(observer1 is calls[0])
  ok(observer2 is calls[1])

test "it should not fail if no observers", ->
  ok !(@observable.notify("event"))

test "it should notify only relevant observers", ->
  calls = []
  @observable.observe "event", -> calls.push("event")
  @observable.observe "other", -> calls.push("other")
  @observable.notify("other")

  deepEqual(calls, ["other"])