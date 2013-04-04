tddjs.namespace("ajax").create = ->
  options = [
    -> new ActiveXObject("Microsoft.XMLHTTP"),
    -> new XMLHttpRequest()
  ]

  for value in options
    try              # duplication in code execution, runs everytime, fix by
      return value() # figuring out which object is available before defining it
    catch e

  return null