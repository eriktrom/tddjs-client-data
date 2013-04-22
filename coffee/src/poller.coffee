do ->
  ajax = tddjs.namespace("ajax")

  start = ->
    unless @url then throw new TypeError("Must specify URL to poll")

    poller = @

    # ajax.request @url,
      # complete: ->
        # setTimeout ->
        #   poller.start()
        # , 1000

  ajax.poller = {
    start
  }