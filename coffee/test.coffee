output = (text, color) ->
  p = document.createElement("p")
  p.innerHTML = text
  p.style.color = color
  document.body.appendChild(p)


assert = (message, expr) ->
  if !expr
    throw new Error(message)
  assert.count++
  true

assert.count = 0


date = new Date(2009, 9, 2)

try
  assert("%Y should return full year", date.strftime("%Y") is "2009")
  assert("%m should return month", date.strftime("%m") is "10")
  assert("%d should return date", date.strftime("%d") is "02")
  assert("%y should return year as two digits", date.strftime("%y") is "09")
  assert("%F should act as %Y-%m-%d", date.strftime("%F") is "2009-10-02")

  output("#{assert.count} tests OK", "#0c0")
catch e
  output("Test failed: #{e.message}", "#c00")