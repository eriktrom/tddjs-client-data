do ->

  _observers = (observable, event) ->
    observable.observers = {} unless observable.observers
    observable.observers[event] = [] unless observable.observers[event]
    observable.observers[event]

  observe = (event, observer) ->
    if typeof observer isnt "function"
      throw new TypeError("observer is not a function")
    _observers(this, event).push(observer)

  hasObserver = (event, observer) ->
    observers = _observers(this, event)
    for obsvr in observers
      return true if obsvr is observer
    false

  notify = (event) ->
    observers = _observers(this, event)
    args = Array::slice.call(arguments, 1)
    for obsvr in observers
      try
        obsvr.apply(@, args)
      catch e
        # its observers responsibility to handle errors properly, pg 233
    return

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