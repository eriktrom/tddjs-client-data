do ->
  ajax = tddjs.namespace("ajax")

  unless ajax.create then return

  requestComplete = (transport, options) ->
    if transport.status is 200 && typeof options.success is "function"
      options.success(transport)

  get = (url, options) ->
    if typeof url isnt "string" then throw new TypeError("URL should be string")
    options = options || {}
    transport = ajax.create()
    transport.open("GET", url, true)
    transport.onreadystatechange = ->
      requestComplete(transport, options) if transport.readyState is 4
    transport.send()
    return

  ajax.get = get