describe "Namespacing", ->

  afterEach -> delete tddjs.nstest

  it "should create a non existant object", ->
    tddjs.namespace("nstest")
    expect(tddjs.nstest).toBeObject()

  it "should not overwrite existing objects", ->
    tddjs.nstest = { nested: {} }
    result = tddjs.namespace("nstest.nested")
    expect(tddjs.nstest.nested).toBe result

  it "only creates missing parts", ->
    existing = {}
    tddjs.nstest = nested: existing: existing
    expect(tddjs.nstest.nested.existing).toBe existing
    result = tddjs.namespace("nstest.nested.ui")
    expect(tddjs.nstest.nested.ui).toBeObject()

  describe "only creates missing parts(Given/When/Then Version)", ->
    Given "An existing namespace", ->
      @existing = {}
    When "I inject the existing namespace into an existing nested namespace", ->
      tddjs.nstest = nested: existing: @existing
      tddjs.namespace("nstest.nested.ui")
    Then "The existing namespace should === itself when nested", ->
      expect(tddjs.nstest.nested.existing).toBe @existing
    Then "The nested namespace should be unmodified otherwise", ->
      expect(tddjs.nstest.nested.ui).toBeObject()

describe "Uid for objects", ->
  it "should return a numeric id", ->
    id = tddjs.uid({})
    expect(id).toBeNumber()

  it "should return consistent id for object", ->
    object = {}
    id = tddjs.uid(object)
    expect(tddjs.uid(object)).toBe id

  it "should return unique id", ->
    object = {}
    object2 = {}
    id = tddjs.uid(object)
    expect(tddjs.uid(object2)).not.toEqual id

  it "should return consistent id for function", ->
    func = ->
    id = tddjs.uid(func)
    expect(tddjs.uid(func)).toBe id

  it "should return undefined for primitive", ->
    string = "my string"
    expect(tddjs.uid(string)).toBeUndefined()


describe "a Circle", ->
  Given -> @circle = new Circle(6)

  describe "created via constructor function", ->
    Then -> expect(@circle).toBeInstanceOf Object
    Then -> expect(@circle).toBeInstanceOf Circle
    Then -> expect(@circle.constructor).toEqual Circle

  describe "created via object literal", ->
    Given -> @circ2 = radius: 6
    Then -> expect(@circ2).toBeInstanceOf Object
    Then -> expect(@circ2.constructor).toEqual Object

  describe "created via new @circle.constructor", ->
    When -> @circle2 = new @circle.constructor(9)
    Then -> expect(@circle2.constructor).toEqual @circle.constructor
    Then -> expect(@circle2).toBeInstanceOf Circle

  describe "inheriting properties from Circle.prototype", ->
    Then -> expect(@circle.diameter()).toEqual 12
    Then -> expect(@circle.circumference()).toEqual 37.69911184307752
    it "should calculate area of @circle", ->
      expect(@circle.area()).toEqual 113.09733552923255

  describe "constructor is Object when prototype is overridden", ->
    Given -> @Circle = ->
    When -> @Circle.prototype = {}
    Then -> expect(new @Circle().constructor).toEqual Object

  describe "calling prototype without 'new' returns undefined", ->
    Given -> @circle = Circle(6)
    Then -> expect(@circle).toBeOfType "undefined"
    Then "it defines radius on the global scope, but not as 6(anymore)", ->
      expect(radius).toBeOfType "function"
      # it seems we've still defined radius on the global scope, but
      # at least its now returning itself as an uncalled funtion(although I
      # don't know why)

describe "Function inherit", ->
  Given ->
    @SubFn = ->
    @SuperFn = ->
  When -> @SubFn.inherit(@SuperFn)
  Then "it should link prototypes", ->
    expect(new @SubFn()).toBeInstanceOf @SuperFn
  Then "it should setup a link to super", ->
    expect(@SubFn::_super).toEqual @SuperFn::

describe "a Sphere", ->
  Given -> @sphere = new Sphere(6)
  Then -> expect(@sphere).toBeInstanceOf Sphere
  Then -> expect(@sphere).toBeInstanceOf Circle
  Then -> expect(@sphere).toBeInstanceOf Object
  Then -> expect(@sphere.diameter()).toEqual 12
  xit "should calculate sphere area", ->
    expect(Math.round(@sphere.area())).toEqual 452

describe "create a circle object with function(crockford style)", ->
  Given -> @circ = circle(6)
  Then -> expect(@circ.radius()).toEqual 6
  describe "resetting the radius", ->
    When -> @circ.radius(12)
    Then -> expect(@circ.radius()).toEqual 12
    Then -> expect(@circ.diameter()).toEqual 24


describe "Object.create", ->
  xit "sphere should inherit from circle", ->
    circle =
      radius: 6
      area: -> radius * radius * Math.PI
    sphere = Object.create(circle)
    sphere.area = -> 4 * circle.area.call(@)
    expect(Math.round(sphere.area())).toEqual 452
  xdescribe "another way to test that throws a different error", ->
    Given ->
      @circle =
        radius: 6
        area: -> radius * radius * Math.PI
    Given -> @sphere = Object.create(@circle)
    Given -> @sphere.area = -> 4 * @circle.area.call(@)
    Then "sphere should inherit from circle", ->
      expect(Math.round(@sphere.area())).toEqual 452
describe "creating more spheres based on existing", ->
  # this will not work when splitting it up into beforeEach or Given
  # or anything dependent on scope changes(I think) - even though everything
  # is defined on this
  When ->
    @circle = new Circle(6)
    @sphere = Object.create(@circle)
    @sphere.area = -> 4 * @circle.area.call(@)
    @sphere2 = Object.create(@sphere)
    @sphere2.radius = 10
    expect(Math.round(@sphere2.area())).toEqual 1257


describe "Object Extend", ->
  Given ->
    @dummy =
      setName: (name) ->
        @name = name
      getName: ->
        @name || null
    @object = {}

    describe "it should copy properties", ->
      When -> tddjs.extend(@object, @dummy)
      Then -> expect(@object.getName).toBeFunction()
      Then -> expect(@object.setName).toBeFunction()

    describe "it should return a new object when the source is null", ->
      When -> tddjs.extend(null, @dummy)
      Then -> expect(@object.getName).toBeFunction()
      Then -> expect(@object.setName).toBeFunction()

    describe "it should return target untouched when no source given", ->
      When ->
        object = tddjs.extend({})
        properties = []
        for prop of object
          if tddjs.isOwnProperty(object, prop)
            properties.push(prop)
        expect(properties.length).toEqual 0

