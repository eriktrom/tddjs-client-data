do ->

  addObserver = (observer) ->
    unless @observers then @observers = []
    if typeof observer isnt "function"
      throw new TypeError("observer is not a function")
    @observers.push(observer)

  hasObserver = (observer) ->
    return false unless @observers
    for obsvr in @observers
      return true if obsvr is observer
    false

  notifyObservers = ->
    return unless @observers
    for obsvr in @observers
      try
        obsvr.apply(@, arguments)
      catch e
        # its observers responsibility to handle errors properly, pg 233
        

  tddjs.namespace("util").observable = {
    addObserver
    hasObserver
    notifyObservers
  }










# class Observable
#   constructor: ->
#     @observers = []

#   addObserver: (observer) ->
#     @observers.push(observer)

#   tddjs.util.Observable = Observable