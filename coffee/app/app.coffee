tddjs.namespace("util")

# do ->
#   Observable = ->
#   addObserver = (observer) ->
#     @observers = [observer]
#   Observable::addObserver = addObserver
#   tddjs.util.Observable = Observable
#   return

class Observable
  constructor: ->
    @observers = []

  addObserver: (observer) ->
    @observers.push(observer)

  tddjs.util.Observable = Observable