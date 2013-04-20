tddjs.noop = -> # create a clean scope chain

do ->
  ajax = tddjs.namespace("ajax")
  util = tddjs.namespace("util")
  return if !ajax.create

  isSuccess = (transport) ->
    transport.status is 200 || (tddjs.isLocal() && !transport.status)

  requestComplete = (transport, opts) ->
    if isSuccess(transport)
      opts.success(transport) if typeof opts.success is "function"
      opts.failure(transport) if typeof opts.failure is "function"

  setData = (opts) ->
    if opts.data
      opts.data = tddjs.util.urlParams(opts.data)
      if opts.method is "GET"
        opts.url += "?#{opts.data}"
        opts.data = null
    else
      opts.data = null


  request = (url, opts) ->
    if typeof url isnt "string" then throw new TypeError("URL should be string")

    opts = tddjs.extend({}, opts)
    opts.url = url
    setData(opts)

    transport = ajax.create()

    transport.open(opts.method || "GET", opts.url, true)

    transport.onreadystatechange = ->
      if transport.readyState is 4
        requestComplete(transport, opts)
        transport.onreadystatechange = tddjs.noop # break IE circular reference memory leak pg 272

    headers = opts.headers || {}
    tddjs.each headers, (header, value) ->
      transport.setRequestHeader(header, value)

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
