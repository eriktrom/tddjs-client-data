stubFn = (returnValue) ->
  fn = ->
    fn.called = true
    fn.args = Array::slice.call(arguments)
    # fn.args = arguments
    returnValue
  fn.called = false
  fn


XMLHttpRequestDbl = {
  open: stubFn()
  send: stubFn()
  # change/set the ready state and call the onreadystatechange handler
  readyStateChange: (readyState) ->
    @readyState = readyState
    @onreadystatechange()

  setRequestHeader: (header, value) ->
    if !@headers
      @headers = {}
    @headers[header] = value

  complete: ->
    @status = 200
    @readyStateChange(4)
}

do ->
  okNumber = (actual) ->
    !isNaN(parseFloat(actual)) &&
    !(Object.prototype.toString.call(actual) is "[object Number]")

  okFunction = (actual) ->
    Object::toString.call(actual) is "[object Function]" # pg. 191 js-definitive-guide

  okObject = (actual) ->
    Object::toString.call(actual) is "[object Object]"


  tddjs.namespace("util").matchers = {
    okNumber
    okFunction
    okObject
  }


do ->
  ajax = tddjs.ajax
  ###*
   * A test helper to force the value of a the status and ready state
   * @param  {Object} xhr        a fake xhr object
   * @param  {Number} status     a fake http status code (e.g. 200)
   * @param  {Number} readyState a fake xhr ready state (e.g. 4)
   * @return {Object}            returns an object with properties successIsCalled
   *                                     and failureIsCalled, used for indicating if the
   *                                     corresponding callback was called.
   *                                     completeIsCalled is also a property of
   *                                     this returned object - added in chpt 13
   *                                     it is called when a request is complete,
   *                                     regardless of success
   *
   *  The reason for the complete callback is for polling. Issuing new requests
   *  without knowing whether or not previous requests completed could lead
   *  to multiple simultaneious connections. A better solution is to trigger
   *  a delayed request once the previous one finishes.
  ###
  forceStatusAndReadyState = (xhr, status, readyState) ->
    success = stubFn()
    failure = stubFn()
    complete = stubFn()

    ajax.request("/url", {success, failure, complete})
    xhr.complete(status, readyState)

    successHasBeenCalled: success.called
    failureHasBeenCalled: failure.called
    completeHasBeenCalled: complete.called

  tddjs.namespace("util").testHelpers = {
    forceStatusAndReadyState
  }