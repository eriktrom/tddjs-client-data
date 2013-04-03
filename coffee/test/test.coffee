module "Observable"

test "it adds observers", ->
  observable = new tddjs.util.Observable()
  observer1 = ->
  observer2 = ->
  observers = [observer1, observer2]

  observable.addObserver(observers[0])
  observable.addObserver(observers[1])

  deepEqual(observable.observers, observers)