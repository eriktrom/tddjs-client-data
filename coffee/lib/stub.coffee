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

  setRequestHeader: (header, value) ->
    if !@headers
      @headers = {}
    @headers[header] = value
}



