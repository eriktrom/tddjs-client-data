# when the request is complete, the poller should schedule another request.
# Scheduling ahead of time is done with timers, typically setTimout.
#
# Because the new request will end up calling the same callback that scheduled
# it, another one will be scheduled and we have a continuous polling scheme,
# even without setInterval. To understand this, we'll need to understand how
# to test timers.

do ->
  ajax = tddjs.namespace("ajax")

  start = ->
    unless @url then throw new TypeError("Must specify URL to poll")
    ajax.request @url

  ajax.poller = {
    start
  }