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
  return if typeof tddjs is "undefined"
  ajax = tddjs.namespace("ajax")
  return if !ajax.create || !Object.create

  start = ->
    unless @url then throw new TypeError("Must specify URL to poll")

    interval = 1000
    if typeof @interval is "number"
      interval = @interval

    requestStart = new Date().getTime()
    urlWithCacheBust = "#{@url}?#{requestStart}"
    # TODO: url will break if it already includes query parameters before we
    # add ours - pg 320 & chpt 12, twice left as exercise to the reader
    self = @
    ajax.request urlWithCacheBust,
      complete: ->
        elapsed = new Date().getTime() - requestStart
        remaining = interval - elapsed

        setTimeout ->
          self.start()
        , Math.max(0, remaining)
        self.complete() if typeof self.complete is "function"
      headers: self.headers
      success: self.success
      failure: self.failure

  ajax.poller = {
    start
  }

do ->
  ajax = tddjs.namespace("ajax")

  poll = (url, opts) ->
    poller = Object.create(ajax.poller)
    poller.url = url
    opts = opts || {}
    poller.headers = opts.headers
    poller.success = opts.success
    poller.failure = opts.failure
    poller.complete = opts.complete
    poller.interval = opts.interval
    poller.start()
    poller

  ajax.poll = poll