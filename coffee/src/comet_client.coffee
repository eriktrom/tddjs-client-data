do ->
  return if typeof tddjs is "undefined"
  ajax = tddjs.namespace("ajax")
  util = tddjs.namespace("util")
  # return if !ajax.poll || !util.observable # <-- fuck me

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
    headers =
      "Content-Type": "application/json"
      "X-Access-Token": ""
    @poller ||= ajax.poll @url,
      success: (xhr) =>
        try
          data = JSON.parse(xhr.responseText)
          headers["X-Access-Token"] = data.token
          @dispatch(data)
        catch e
      headers: headers

  notify = ->





  ajax.cometClient = {
    dispatch
    observe
    connect
    notify
  }