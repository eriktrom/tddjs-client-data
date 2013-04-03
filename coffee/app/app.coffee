tddjs.namespace("util")

do ->
  Observable = ->
    @observers = []
    return

  Observable::addObserver = (observer) ->
    @observers.push(observer)

  Observable::hasObserver = (observer) ->
    for obsvr in @observers
      return true if obsvr is observer
    false
    # @observers.indexOf(observer) >= 0

  tddjs.util.Observable = Observable

# class Observable
#   constructor: ->
#     @observers = []

#   addObserver: (observer) ->
#     @observers.push(observer)

#   tddjs.util.Observable = Observable