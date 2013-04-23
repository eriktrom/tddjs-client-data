do ->
  ajax = tddjs.namespace("ajax")
  util = tddjs.namespace("util")

  dispatch = (data) ->
    observers = @observers
    return if !observers || typeof observers.notify isnt "function"

    tddjs.each data, (topic, events) ->
      events ?= []
      for event in events
        observers.notify(topic, event)
      return

  observe = (topic, observer) ->
    if !@observers
      @observers = Object.create(util.observable)

    @observers.observe(topic, observer)

  ajax.cometClient = {
    dispatch
    observe
  }