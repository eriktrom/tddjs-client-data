# benchmark.coffee
runBenchmark = (name, test) ->
  if !ol
    ol = document.createElement("ol")
    document.body.appendChild(ol)
setTimeout = ->
  start = new Date().getTime()
  test()
  total = new Date().getTime() - start

  li = document.createElement("li")
  li.innerHTML = "#{name}: #{total}ms"
  ol.appendChild(li)
, 15

# benchmarks/loops.js
loopLength = 500000
array = []

forLoop = ->
  i = 0
  item = undefined

  while i < array.length
    item = array[i]
    i++
forLoopCachedLength = ->
  i = 0
  l = array.length
  item = undefined

  while i < l
    item = array[i]
    i++
forLoopDirectAccess = ->
  i = 0
  item = undefined

  while (item = array[i])
    i++
whileLoop = ->
  i = 0
  item = undefined
  while i < array.length
    item = array[i]
    i++
whileLoopCachedLength = ->
  i = 0
  l = array.length
  item = undefined
  while i < l
    item = array[i]
    i++
reversedWhileLoop = ->
  l = array.length
  item = undefined
  item = array[l]  while l--
doubleReversedWhileLoop = ->
  l = array.length
  i = l
  item = undefined
  item = array[l - i - 1]  while i--
i = 0

while i < loopLength
  array[i] = "item" + i
  i++

runBenchmark "for-loop", forLoop


# bind function
# if !Function::bind
#   Function::bind = (thisObj) ->
#     target = this
#     ->
#       target.apply(thisObj, arguments)