do ->
  ajax = tddjs.namespace("ajax")

  unless ajax.create then return

  requestComplete = (transport, options) ->
    if transport.status is 200
      if typeof options.success is "function"
        options.success(transport)
        return

  get = (url, options) ->
    if typeof url isnt "string" then throw new TypeError("URL should be string")
    options = options || {}
    transport = ajax.create()
    transport.open("GET", url, true)
    transport.onreadystatechange = ->
      requestComplete(transport, options) if transport.readyState is 4
      return
    transport.send()
    return

  ajax.get = get