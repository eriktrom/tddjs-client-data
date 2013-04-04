do ->
  xhr = null
  ajax = tddjs.namespace("ajax")

  options = [
    -> new ActiveXObject("Microsoft.XMLHTTP"),
    -> new XMLHttpRequest()
  ]

  for option in options
    try
      xhr = option()

      if typeof xhr.readyState is "number" &&
      tddjs.isHostMethod(xhr, "open") &&
      tddjs.isHostMethod(xhr, "send") &&
      tddjs.isHostMethod(xhr, "setRequestHeader")
        ajax.create = option
        break
    catch e
  return