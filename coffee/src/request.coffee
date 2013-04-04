do ->
  ajax = tddjs.namespace("ajax")

  get = (url) ->
    if typeof url isnt "string" then throw new TypeError("URL should be string")

  ajax.get = get