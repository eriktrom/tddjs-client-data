tddjs.noop = -> # create a clean scope chain

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
        transport.onreadystatechange = tddjs.noop # break IE circular reference memory leak pg 272
    transport.send(null) # firefox < 3 will throw if send is called without arg
    return

  ajax.get = get