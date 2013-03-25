assert = (message, expr) ->
  if !expr
    throw new Error(message)
  assert.count++
  true

assert.count = 0

output = (text, color) ->
  p = document.createElement("p")
  p.innerHTML = text
  p.style.color = color
  document.body.appendChild(p)

testCase = (name, tests) ->
  assert.count = 0
  successful = 0
  testCount = 0
  hasSetup = typeof tests.setUp is "function"
  hasTeardown = typeof tests.tearDown is "function"

  for test of tests
    if not /^test/.test(test) then continue
    testCount++
    try
      if hasSetup then tests.setUp()
      tests[test]()
      output(test, "#0c0")
      if hasTeardown then tests.tearDown()
      successful++
    catch e
      output("Test failed: #{e.message}", "#c00")

  text = "<strong>#{testCount} tests #{testCount - successful} failures</strong>"
  color = if successful is testCount then "#0c0" else "#c00"
  output(text, color)


# Actual Tests
testCase "strftime test",
  setUp: ->
    @date = new Date(2009, 9, 2, 22, 14, 45)

  "test format specifier %Y": ->
    assert("%Y should return full year", Date.formats.Y(@date) is 2009)

  "test format specifier %m": ->
    assert("%m should return month", Date.formats.m(@date) is "10")

  "test format specifier %d": ->
    assert("%d should return date", Date.formats.d(@date) is "02")

  "test format specifier %y": ->
    assert("%y should return year as two digits",
           Date.formats.y(@date) is "09")

  "test format shorthand %F": ->
    assert("%F should act as %Y-%m-%d", Date.formats.F is "%Y-%m-%d")

  "test format shorthand %D": ->
    assert("%D should act as %m/%d/%y", Date.formats.D is "%m/%d/%y")