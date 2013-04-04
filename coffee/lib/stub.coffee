stubFn = ->
  fn = -> fn.called = true
  fn.called = false
  fn