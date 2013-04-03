tddjs.namespace("util")

do ->
  Observable = ->
    @observers = []
    return

  Observable::addObserver = (observer) ->
    if typeof observer isnt "function"
      throw new TypeError("observer is not a function")
    @observers.push(observer)

  Observable::hasObserver = (observer) ->
    for obsvr in @observers
      return true if obsvr is observer
    false

  Observable::notifyObservers = ->
    for obsvr in @observers
      obsvr.apply(@, arguments)

  tddjs.util.Observable = Observable






















# class Observable
#   constructor: ->
#     @observers = []

#   addObserver: (observer) ->
#     @observers.push(observer)

#   tddjs.util.Observable = Observable