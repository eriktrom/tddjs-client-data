
do ->
  module "Observable"

  Observable = ->

  test "add observer to observable", ->
    # Given - create observable object
    observable = new Observable() 
    # When - add an observer by calling addObserver on observable
    observable.addObserver(observerDbl)
    # Then - verify that observer is stored inside observers array
    # observable.observers.includes(observerDbl)
    ok(observable.observers[0] is observerDbl) 
    ok(observable.observers.length is 1)

    # this makes assumption that observable keeps its observers in an array
    # named observers (a better name for this array might be listeners/subscribers)