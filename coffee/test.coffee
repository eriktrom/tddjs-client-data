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

describe "A Tabbed Panel", ->
  beforeEach ->
    @tabController = tddjs.ui.tabController
    html =
      """
      <ol id="tabs">
        <li><a href="#news">News</a></li>
        <li><a href="#sports">Sports</a></li>
        <li><a href="#economy">Economy</a></li>
      </ol>
      """
    setFixtures(html)
    @tabs = document.getElementById("tabs")

  describe "tabController.create", ->
    it "should fail without an element", ->
      expect(-> @tabController.create()).toThrowErrorOfType('TypeError')

    it "should fail without element class", ->
      expect(-> @tabController.create({})).toThrowErrorOfType('TypeError')

    it "should return object", ->
      controller = @tabController.create(@tabs)
      expect(controller).toBeObject()

    it "should add js-tabs class name to element", ->
      @tabController.create(@tabs)
      expect(tabs).toHaveClass('js-tab-controller')
