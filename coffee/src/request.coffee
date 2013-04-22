tddjs.noop = -> # create a clean scope chain

do ->
  ajax = tddjs.namespace("ajax")
  util = tddjs.namespace("util")
  return if !ajax.create

  isSuccess = (transport) ->
    status = transport.status
    result =
      (status >= 200 && status < 300) ||
      status is 304 ||
      (tddjs.isLocal() && !status)
    result

  isFailure = (transport) ->
    status = transport.status
    result =
      status is 400
    result

  requestComplete = (opts) ->
    transport = opts.transport
    if isSuccess(transport)
      opts.success(transport) if typeof opts.success is "function"
    if isFailure(transport)
      opts.failure(transport) if typeof opts.failure is "function"

    opts.complete(transport) if typeof opts.complete is "function"

  setData = (opts) ->
    if opts.data
      opts.data = tddjs.util.urlParams(opts.data)
      if opts.method is "GET"
        hasParams = opts.url.indexOf("?") >= 0
        opts.url += if hasParams then "&" else "?"
        opts.url += opts.data
        opts.data = null
    else
      opts.data = null

  defaultHeader = (transport, headers, header, val) ->
    if !headers[header] then transport.setRequestHeader(header, val)

  setHeaders = (opts) ->
    headers = opts.headers || {}
    transport = opts.transport

    tddjs.each headers, (header, value) ->
      transport.setRequestHeader(header, value)

    if opts.method is "POST" && opts.data
      defaultHeader(transport, headers,
                    "Content-Type", "application/x-www-form-urlencoded")
      defaultHeader(transport, headers,
                    "Content-Length", opts.data.length)

    defaultHeader(transport, headers,
                  "X-Requested-With", "XMLHttpRequest")

  request = (url, opts) ->
    if typeof url isnt "string" then throw new TypeError("URL should be string")

    opts = tddjs.extend({}, opts)
    opts.url = url
    setData(opts)

    transport = ajax.create()
    opts.transport = transport
    transport.open(opts.method || "GET", opts.url, true)
    setHeaders(opts)

    transport.onreadystatechange = ->
      if transport.readyState is 4
        requestComplete(opts)
        transport.onreadystatechange = tddjs.noop # break IE circular reference memory leak pg 272

    transport.send(opts.data) # firefox < 3 will throw if send is called without arg
    return

  get = (url, opts) ->
    opts = tddjs.extend({}, opts)
    opts.method = "GET"
    ajax.request(url, opts)
    return

  post = (url, opts) ->
    opts = tddjs.extend({}, opts)
    opts.method = "POST"
    ajax.request(url, opts)
    return
    # Im thinking of putting return at the end of any methods that 'do'
    # work instead of returning a value

  ajax.post = post
  ajax.get = get
  ajax.request = request

do -> # simplified url parameter encoder
  return if typeof encodeURIComponent is "undefined"

  urlParams = (object) ->
    return "" if !object
    return encodeURI(object) if typeof object is "string"

    pieces = []
    tddjs.each object, (prop, val) ->
      pieces.push("#{encodeURIComponent(prop)}=#{encodeURIComponent(val)}")

    pieces.join("&")

  tddjs.namespace("util").urlParams = urlParams
