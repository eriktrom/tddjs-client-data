do ->
  ajax = tddjs.namespace("ajax")
  unless ajax.create then return

  get = (url) ->
    if typeof url isnt "string" then throw new TypeError("URL should be string")
    transport = tddjs.ajax.create()
    transport.open("GET", url, true)
    transport.onreadystatechange = ->
    return

  ajax.get = get