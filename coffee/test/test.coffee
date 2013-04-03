


do ->
  module "Observable"

  class Observable
    constructor: ->
      @observers = []
    addObserver: (observer) ->
      @observers.push(observer)
    # @observers = []

    # addObserver: (observer) ->
    #   @observers.push(observer)

  # Observable = ->
  #   @observers = []

  #   Observable::addObserver = (observer) ->
  #     @observers.push(observer)
  #     return

  #   return

  test "add observer to observable", -> 
    # Given - create observable object
    observable = new Observable()
    observerDbl = {} # nothing fancy, just want to check object identity later

    # When - add an observer by calling addObserver on observable
    observable.addObserver(observerDbl)

    # Then - verify that observer is ostored inside observers array
    # observable.observers.includes(observerDbl)
    ok(observable.observers[0] is observerDbl)
    # and that its the only item in that array (necessary?)
    ok(observable.observers.length is 1)

  test "observable has an observers array", ->
    observable = new Observable()
    ok(observable.observers instanceof Array)
