### apply takes two arguments
  the first is this
  the second is an array of arguments to pass to the function being called
    does not need to be actual array, array like object will do which means
    you can pass arguments as the second arg and therefore means you can
    chaing together function calls passing arguments down the chain, this
    must be what promises are for or something, but we'll see
###

sum = ->
  total = 0
  for index of arguments
    total = total + arguments[index]
  total

describe "sum", ->
  it "shuld sum the numbers", ->
    expected = sum(1, 2, 3, 4, 5)
    expect(expected).toEqual 15

  it "should sum the numbers using apply", ->
    expected = sum.apply(null, [1, 2, 3, 4, 5])
    expect(expected).toEqual 15