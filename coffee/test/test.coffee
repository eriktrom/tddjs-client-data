module "ObservableAddObserverTest"

test "it should store a function", ->
  observable = new tddjs.util.Observable()
  observer = ->

  observable.addObserver(observer)

  ok(observer is observable.observers[0])