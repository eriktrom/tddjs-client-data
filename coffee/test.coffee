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
  describe "created via constructor function", ->
    Given -> @circ = new Circle(6)
    Then -> expect(@circ).toBeInstanceOf Object
    Then -> expect(@circ).toBeInstanceOf Circle
    Then -> expect(@circ.constructor).toEqual Circle
    # we could also use And here - the difference is that with And, the Given above is not re-run, and thus 3 things are worth noting:
    # 1) the Given remains idempotent,
    # 2) we get a performance boost,
    # 3) the test output only shows tests for Then, and thus using And does not increase the number of tests, although it does provide the right place of failure, so it works just as good at determining point of failure
    # And -> expect(@circ.constructor).toEqual Circle
  describe "created via object literal", ->
    Given -> @circ2 = radius: 6
    Then -> expect(@circ2).toBeInstanceOf Object
    Then -> expect(@circ2.constructor).toEqual Object


