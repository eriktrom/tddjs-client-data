tddjs.noop = -> # create a clean scope chain

do ->
  ajax = tddjs.namespace("ajax")
  return if !ajax.create

  isSuccess = (transport) ->
    transport.status is 200 || (tddjs.isLocal() && !transport.status)

  requestComplete = (transport, opts) ->
    if isSuccess(transport)
      opts.success(transport) if typeof opts.success is "function"
      opts.failure(transport) if typeof opts.failure is "function"

  request = (url, opts) ->
    if typeof url isnt "string" then throw new TypeError("URL should be string")
    opts = opts || {}
    transport = ajax.create()
    transport.open(opts.method || "GET", url, true)
    transport.onreadystatechange = ->
      if transport.readyState is 4
        requestComplete(transport, opts)
        transport.onreadystatechange = tddjs.noop # break IE circular reference memory leak pg 272
    transport.send(null) # firefox < 3 will throw if send is called without arg
    return

  get = (url, opts) -> request(url, opts)

  ajax.get = get
  ajax.request = request