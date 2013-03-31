tddjs = do ->
  namespace = (string) ->
    object = this
    levels = string.split(".")
    for level in levels
      if typeof object[level] is "undefined"
        object[level] = {}
      object = object[level]
    object

  namespace: namespace