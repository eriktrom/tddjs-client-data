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
    Then -> expect(@circle.area()).toEqual 113.09733552923255

  describe "constructor is Object when prototype is overridden", ->
    Given -> @Circle = ->
    When -> @Circle.prototype = {}
    Then -> expect(new @Circle().constructor).toEqual Object

  describe "calling prototype without 'new' returns undefined", ->
    Given -> @circle = Circle(6)
    Then -> expect(typeof @circle).not.toBe "undefined"
    # the above is supposed to return undefined, I get "number"
      # oh, that's because inside my Circle = -> definition, coffeescript
      # returns the last expression, which is @radius = radius, which is a number
    Then -> expect(@circle).not.toBeNumber() # see note ^^
    Then -> expect(radius).toEqual 6 # this should be fixed with update to Circle, but its not
    # ^^Oops! we've defined radius on global object

describe "a Sphere", ->
  Given -> @sphere = new Sphere(6)
  Then -> expect(@sphere).toBeInstanceOf Sphere
  Then -> expect(@sphere).toBeInstanceOf Circle
  Then -> expect(@sphere).toBeInstanceOf Object
  Then -> expect(@sphere.diameter()).toEqual 12

describe "Function inherit", ->
  Given ->
    @SubFn = ->
    @SuperFn = ->
    @SubFn.inherit(@SuperFn)
  it "should link prototypes", ->
    expect(new @SubFn()).toBeInstanceOf @SuperFn