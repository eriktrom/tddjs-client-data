module "Observable",
  setup: ->
    @observable = new tddjs.util.Observable()

test "it adds observers", ->
  observers = [(->), (->)]

  @observable.addObserver(observers[0])
  @observable.addObserver(observers[1])

  deepEqual(@observable.observers, observers)

  # this was his refactoring, it looks like coupling to me - what if we
  # move or change hasObserver? this will fail and we'll have to fix it
  ok(@observable.hasObserver(observers[0]))
  ok(@observable.hasObserver(observers[1]))

test "it returns true when it has observer(s)", ->
  observer = ->

  @observable.addObserver(observer)

  ok(@observable.hasObserver(observer))

test "it returns false when it has no observer(s)", ->
  ok !(@observable.hasObserver(->))


test "it calls all observers", ->
  observer1 = -> observer1.called = true
  observer2 = -> observer2.called = true

  @observable.addObserver(observer1)
  @observable.addObserver(observer2)
  @observable.notifyObservers()

  ok(observer1.called)
  ok(observer2.called)

test "it should pass through arguments", ->
  actual = null

  @observable.addObserver -> actual = arguments

  @observable.notifyObservers("String", 1, 32)

  deepEqual(Array::slice.call(actual, 0), ["String", 1, 32])

test "it should throw for uncallable observer", ->
  throws ->
    @observable.addObserver({})
  , TypeError

test "it should notify all even when some fail", ->
  observer1 = -> throw new Error("Oops")
  observer2 = -> observer2.called = true

  @observable.addObserver(observer1)
  @observable.addObserver(observer2)
  @observable.notifyObservers()

  ok(observer2.called)