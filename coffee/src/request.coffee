tddjs.noop = ->

do ->
  ajax = tddjs.namespace("ajax")
  if !ajax.create then return

  requestComplete = (transport, options) ->
    if transport.status is 200 || (tddjs.isLocal() && !transport.status)
      if typeof options.success is "function"
        options.success(transport)

  get = (url, options) ->
    if typeof url isnt "string" then throw new TypeError("URL should be string")
    options = options || {}
    transport = ajax.create()
    transport.open("GET", url, true)
    transport.onreadystatechange = ->
      if transport.readyState is 4
        requestComplete(transport, options)
        transport.onreadystatechange = tddjs.noop
    transport.send(null)
    return

  ajax.get = get