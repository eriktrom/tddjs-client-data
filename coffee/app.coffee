tddjs = (->
  namespace = (string) ->
    object = this
    levels = string.split(".")
    for level in levels
      if typeof object[level] is "undefined"
        object[level] = {}
      object = object[level]
    object

  namespace: namespace
)()

(->
  id = 0
  uid = (object) ->
    if typeof object.__uid != "number"
      object.__uid = id++
    object.__uid
  if typeof tddjs == "object"
    tddjs.uid = uid
)()

Circle = (radius) ->
  @radius = radius

circ = new Circle(6)
circ2 = radius: 6