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
    @observers ||= Object.create(util.observable)
    @observers.observe(topic, observer)

  connect = ->
    unless @url then throw new TypeError("cometClient url is null")
    @poller ||= ajax.poll @url,
      success: (xhr) =>
        @dispatch(JSON.parse(xhr.responseText))
      headers:
        "Content-Type": "application/json"
        "X-Access-Token": ""

  ajax.cometClient = {
    dispatch
    observe
    connect
  }