stubFn = (returnValue) ->
  fn = ->
    fn.called = true
    returnValue
  fn.called = false
  fn