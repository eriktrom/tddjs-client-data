do ->
  ajax = tddjs.namespace("ajax")

  start = ->
    unless @url then throw new TypeError("Must specify URL to poll")
    ajax.request @url

  ajax.poller = {
    start
  }