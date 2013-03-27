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
  if !(this instanceof Circle)
    @new_instance = new Circle(radius)
  @radius = radius
  @new_instance

# without constructor property below, instances of this constructor
# function will have a different 'constructor' property, namely Object
# instead of Circle
# setting the constructor property to Circle works, but there is another
# problem
# When we overwrite the prototype property, and then its constructor property
# we lose the DontEnum attribute of the constructor property, which is
# impossible for us to fix, thus the solution below, is not the best either
# Circle.prototype = {
#   constructor: Circle
#   diameter: -> @radius * 2
#   circumference: -> @diameter() * Math.PI
#   area: -> @radius * @radius * Math.PI
# }

# Here is a solution however that works
# We extend the given prototype property in a closure
# which is better than the previous because we avoid its constructor property
# from being enumberable
((p) ->
  p.diameter = -> @radius * 2
  p.circumference = -> @diameter() * Math.PI
  p.area = -> @radius * @radius * Math.PI
)(Circle.prototype)


# implementing super
# We need Sphere.prototype to refer to an object whose internal [[Prototype]]
# is Circle.prototype
# Need circle object to setup this link
# In order to get the circle object, we need to invoke the Circle constructor
# aka, new Circle(6)
# BUT
# our constructor may provide the prototype object with unwanted state, and
# it may even fail in the absence of input arguments
# the current solution is to use the following intermediate constructor that
# borrows Circle.prototype
# Sphere = (radius) ->
#   @radius = radius
#   undefined

# Sphere.prototype = ->
#   F = ->
#   F.prototype = Circle.prototype
#   new F()
#
# Sphere.prototype.constructor = Sphere
# IS REPLACED BY:
unless Function::inherit
  (->
    F = ->
    Function::inherit = (superFn) ->
      F.prototype = superFn.prototype
      @prototype = new F()
      @prototype.constructor = this
  )()

Sphere = (radius) ->
  @radius = radius

Sphere.inherit(Circle)

