tddjs.namespace("util")

do ->
  Observable = ->
    @observers = []
    return

  Observable::addObserver = (observer) ->
    @observers.push(observer)

  tddjs.util.Observable = Observable

# class Observable
#   constructor: ->
#     @observers = []

#   addObserver: (observer) ->
#     @observers.push(observer)

#   tddjs.util.Observable = Observable