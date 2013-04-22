# when the request is complete, the poller should schedule another request.
# Scheduling ahead of time is done with timers, typically setTimout.
#
# Because the new request will end up calling the same callback that scheduled
# it, another one will be scheduled and we have a continuous polling scheme,
# even without setInterval. To understand this, we'll need to understand how
# to test timers.

# sheduling a new request
# In order to test that the poller schedules new requests we need to:
# 1. Create a poller with a URL
# 2. Start the poller
# 3. Simulate the first request completing
# 4. Stub the send method over AGAIN
# 5. Fast forward time the desired amount of milliseconds
# 6. Assert that the send method is called a second time (it should be called
# while the clock passed time)

do ->
  ajax = tddjs.namespace("ajax")

  start = ->
    unless @url then throw new TypeError("Must specify URL to poll")
    ajax.request @url

  ajax.poller = {
    start
  }