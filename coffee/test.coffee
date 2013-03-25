YUI(
  combine: true
  timeout: 10000
).use("node", "console", "test", (Y) ->
  assert = Y.Assert

  strftimeTestCase = new Y.Test.Case(
    name: "Date.prototype.strftime Tests"

    setUp: -> @date = new Date(2009, 9, 2, 22, 14, 45)
    tearDown: -> delete @date

    "test %Y should return full year": ->
      year = Date.formats.Y(@date)
      assert.isNumber(year)
      assert.areEqual(2009, year)

    "test %m should return month": ->
      month = Date.formats.m(@date)
      assert.isString(month)
      assert.areEqual("10", month)

    "test %d should return date": ->
      assert.areEqual("02", Date.formats.d(@date))

    "test %y should return year as two digits": ->
      assert.areEqual("09", Date.formats.y(@date))

    "test %F should act as %Y-%m-%d": ->
      assert.areEqual("2009-10-02", @date.strftime("%F"))
  )

  r = new Y.Console
    newestOnTop: false
    style: 'block'

  r.render("#testReport")
  Y.Test.Runner.add(strftimeTestCase)
  Y.Test.Runner.run()
)



