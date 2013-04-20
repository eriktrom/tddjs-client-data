unless Function::bind
  do ->
    slice = Array::slice

    Function::bind = (thisObj) ->
      target = @

      if arguments.length > 1
        args = slice.call(arguments, 1)
        return ->
          allArgs = args
          if arguments.length > 0
            allArgs = args.concat(slice.call(arguments))
          target.apply(thisObj, allArgs)

      return ->
        if arguments.length > 0
          target.apply(thisObj, arguments)
        target.call(thisObj)

unless Object.create
  do ->
    F = ->
    Object.create = (object) ->
      F:: = object
      new F()

# TODO - understand me
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
}

###*
 * A test helper to force the value of a the status and ready state
 * @param  {Object} xhr        a fake xhr object
 * @param  {Number} status     a fake http status code (e.g. 200)
 * @param  {Number} readyState a fake xhr ready state (e.g. 4)
 * @return {Object}            returns an object with properties success
 *                                     and failure, used for indicating if the
 *                                     corresponding callback was called
###
forceStatusAndReadyState = (xhr, status, readyState) ->
  success = stubFn()
  failure = stubFn()
  ajax.get "/url", success: success, failure: failure

  xhr.status = status
  xhr.readyStateChange(readyState)

  success: success.called
  failure: failure.called


