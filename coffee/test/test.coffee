module "Observable#addObserver"

test "it adds observers", ->
  observable = new tddjs.util.Observable()
  observer1 = ->
  observer2 = ->
  observers = [observer1, observer2]

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