unless Object.create
  do ->
    F = ->
    Object.create = (object) ->
      F:: = object
      new F()

stubFn = (returnValue) ->
  fn = ->
    fn.called = true
    fn.args = Array::slice.call(arguments)
    # fn.args = arguments
    returnValue
  fn.called = false
  fn


fakeXMLHttpRequest = {
  open: stubFn()
  send: stubFn()
}