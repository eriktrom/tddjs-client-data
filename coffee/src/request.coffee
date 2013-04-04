do ->
  ajax = tddjs.namespace("ajax")

  get = (url) ->
    if typeof url isnt "string" then throw new TypeError("URL should be string")
    transport = tddjs.ajax.create()
    transport.open("GET", url, true)
    return

  ajax.get = get