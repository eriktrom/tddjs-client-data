startSuccessfulGetTest = ->
  return unless (output = document.getElementById("output"))

  log = (text) ->
    if output?.innerHTML? then output.innerHTML += text
    # if output && typeof output.innerHTML isnt "undefined"
      output.innerHTML += text
    else document.write(text)

  try
    # if tddjs?.ajax?.get?
    if tddjs.ajax && tddjs.ajax.get
      id = new Date().getTime()
      tddjs.ajax.get "/fragment.html?id=#{id}",
        success: (xhr) -> log(xhr.responseText)
    else log "Browser does not support tddjs.ajax.get"
  catch e
    log "An exception occured: #{e.message}"