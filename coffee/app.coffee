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

tddjs.uid = (->
  id = 0
  uid = (object) ->
    if typeof object.__uid != "number"
      object.__uid = id++
    object.__uid
  if typeof tddjs == "object"
    tddjs.uid = uid
)()

`
tddjs.isOwnProperty = (function () {
  var hasOwn = Object.prototype.hasOwnProperty;

  if (typeof hasOwn == "function") {
    return function (object, property) {
      return hasOwn.call(object, property);
    };
  } else {
    // Provide an emulation if you can live with possibly
    // inaccurate results
  }
}());

tddjs.each = (function () {
  // Returns an array of properties that are not exposed
  // in a for-in loop
  function unEnumerated(object, properties) {
    var length = properties.length;

    for (var i = 0; i < length; i++) {
      object[properties[i]] = true;
    }

    var enumerated = length;

    for (var prop in object) {
      if (tddjs.isOwnProperty(object, prop)) {
        enumerated -= 1;
        object[prop] = false;
      }
    }

    if (!enumerated) {
      return;
    }

    var needsFix = [];

    for (i = 0; i < length; i++) {
      if (object[properties[i]]) {
        needsFix.push(properties[i]);
      }
    }

    return needsFix;
  }

  var oFixes = unEnumerated({},
    ["toString", "toLocaleString", "valueOf",
     "hasOwnProperty", "isPrototypeOf",
     "constructor", "propertyIsEnumerable"]);

  var fFixes = unEnumerated(
    function () {}, ["call", "apply", "prototype"]);

  if (fFixes && oFixes) {
    fFixes = oFixes.concat(fFixes);
  }

  var needsFix = { "object": oFixes, "function": fFixes };

  return function (object, callback) {
    if (typeof callback != "function") {
      throw new TypeError("callback is not a function");
    }

    // Normal loop, should expose all enumerable properties
    // in conforming browsers
    for (var prop in object) {
      if (tddjs.isOwnProperty(object, prop)) {
        callback(prop, object[prop]);
      }
    }

    // Loop additional properties in non-conforming browsers
    var fixes = needsFix[typeof object];

    if (fixes) {
      var property;

      for (var i = 0, l = fixes.length; i < l; i++) {
        property = fixes[i];

        if (tddjs.isOwnProperty(object, property)) {
          callback(property, object[property]);
        }
      }
    }
  };
}());
`

tddjs.extend = (->
  extend = (target, source) ->
    target = target || {}
    if !source then return target
    tddjs.each source, (prop, val) ->
      target[prop] = val
    target
  extend
)()



# `
# function Circle(radius) {
#   function getSetRadius() {
#     if (arguments.length > 0) {
#       if (arguments[0] < 0) {
#         throw new TypeError("Radius should be >= 0");
#       }
#       radius = arguments[0];
#     }
#     return radius;
#   }
#
#   function diameter() {
#     return radius * 2;
#   }
#
#   function circumference() {
#     return diameter() * Math.PI;
#   }
#
#   // Expose privileged methods
#   this.radius = getSetRadius;
#   this.diameter = diameter;
#   this.circumference = circumference;
#   this.radius(radius);
# }
# `

# ^^ above is the javascript version, which works the same way... Are there
# ANY differences? The tests all pass exactly the same.

# Robust version of Circle constructor
# none of the nested functions need this
# outside code cannot tamper with internal state except through the public API
unless Object.create
  (->
    F = ->
    Object.create = (object) ->
      F:: = object
      new F()
    undefined
  )()

Circle = (radius) ->
  getSetRadius = ->
    if arguments.length > 0
      if arguments[0] < 0 then throw new TypeError("Radius should be >= 0")
      radius = arguments[0]
    radius
  diameter = -> radius * 2
  circumference = -> diameter() * Math.PI
  area = -> radius * radius * Math.PI
  # expose priveleged methods
  @radius = getSetRadius
  @diameter = diameter
  @circumference = circumference
  @area = area
  @radius(radius)
  undefined

# crockfords durable object creation
circle = (radius) ->
  getSetRadius = ->
    if arguments.length > 0
      if arguments[0] < 0 then throw new TypeError("Radius should be >= 0")
      radius = arguments[0]
    radius
  diameter = -> radius * 2
  circumference = -> diameter() * Math.PI
  area = -> radius * radius * Math.PI
  radius: getSetRadius
  diameter: diameter
  area: area
  circumference: circumference

# Old notes, will likely be removed after next commit
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
)(Circle::)


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
      F:: = superFn::
      @:: = new F()
      @::constructor = @
      @::_super = superFn::
  )()



Sphere = (radius) ->
  Circle.call(this, radius)

Sphere.inherit(Circle)

Sphere::area = ->
  4 * @_super.area.call(this)


# Private Methods
((circleProto) ->
  # Functions declared in this scope are private and only available to other
  # functions declared in the same scope, they will not be available to methods
  # added to the object or its prototype at a later stage
  ensureValidRadius = (radius) -> radius >= 0
  getRadius = -> @radius
  setRadius = (radius) ->
    if ensureValidRadius(radius)
      @radius = radius
  # assigning the functions to properties of the prototype makes them public
  # methods
  circleProto.getRadius = getRadius
  circleProto.setRadius = setRadius
)(Circle::)

# Object.create is simpler than Function::inherit b/c it only needs to create
# a single object whose prototype is linked to the object argument
