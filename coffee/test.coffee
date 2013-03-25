module "Date.prototype.strftime Tests",
  setup: -> @date = new Date(2009, 9, 2, 22, 14, 45)
  tearDown: -> delete @date

test "%Y should return full year", ->
  year = Date.formats.Y(@date)
  strictEqual(year, 2009)

test "%m should return month", ->
  month = Date.formats.m(@date)
  strictEqual(month, "10")

test "%d should return date", ->
  strictEqual(Date.formats.d(@date), "02")

test "%y should return year as two digits", ->
  strictEqual(Date.formats.y(@date), "09")

test "%F should act as %Y-%m-%d", ->
  strictEqual(@date.strftime("%F"), "2009-10-02")