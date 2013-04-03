do ->

  observe = (event, observer) ->
    unless @observers then @observers = []
    if typeof observer isnt "function"
      throw new TypeError("observer is not a function")
    @observers.push(observer)

  hasObserver = (event, observer) ->
    return false unless @observers
    for obsvr in @observers
      return true if obsvr is observer
    false

  notify = (event) ->
    return unless @observers
    args = Array::slice.call(arguments, 1)
    for obsvr in @observers
      try
        obsvr.apply(@, args)
      catch e
        # its observers responsibility to handle errors properly, pg 233
        

  tddjs.namespace("util").observable = {
    observe
    hasObserver
    notify
  }










# class Observable
#   constructor: ->
#     @observers = []

#   observe: (observer) ->
#     @observers.push(observer)

#   tddjs.util.Observable = Observable