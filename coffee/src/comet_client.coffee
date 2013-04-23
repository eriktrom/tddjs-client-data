do ->
  ajax = tddjs.namespace("ajax")

  dispatch = (data) ->
    observers = @observers
    return if !observers || typeof observers.notify isnt "function"

    tddjs.each data, (topic, events) ->
      events ?= []
      for event in events
        observers.notify(topic, event)
      return

  ajax.cometClient = {
    dispatch
  }