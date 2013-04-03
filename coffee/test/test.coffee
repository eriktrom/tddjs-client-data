module "Observable#addObserver"

test "it adds observers", ->
  observable = new tddjs.util.Observable()
  observers = [(->), (->)]

  observable.addObserver(observers[0])
  observable.addObserver(observers[1])

  deepEqual(observable.observers, observers)

  # this was his refactoring, it looks like coupling to me - what if we
  # move or change hasObserver? this will fail and we'll have to fix it
  ok(observable.hasObserver(observers[0]))
  ok(observable.hasObserver(observers[1]))

module "Observable#hasObserver"

test "it returns true when it has observer(s)", ->
  observable = new tddjs.util.Observable()
  observer = ->

  observable.addObserver(observer)

  ok(observable.hasObserver(observer))

test "it returns false when it has no observer(s)", ->
  observable = new tddjs.util.Observable()

  ok !(observable.hasObserver(->))

module "Observable Notify Observers"

test "it calls all observers", ->
  observable = new tddjs.util.Observable()
  observer1 = -> observer1.called = true
  observer2 = -> observer2.called = true

  observable.addObserver(observer1)
  observable.addObserver(observer2)
  observable.notifyObservers()

  ok(observer1.called)
  ok(observer2.called)

test "it should pass through arguments", ->
  observable = new tddjs.util.Observable()
  actual = null

  observable.addObserver -> actual = arguments

  observable.notifyObservers("String", 1, 32)

  deepEqual(Array::slice.call(actual, 0), ["String", 1, 32])

test "it should throw for uncallable observer", ->
  observable = new tddjs.util.Observable()

  throws ->
    observable.addObserver({})
  , TypeError