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

  describe "tabController.activateTab", ->
    beforeEach ->
      @controller = @tabController.create(@tabs)
      @links = @tabs.getElementsByTagName("a")
      @lis = @tabs.getElementsByTagName("li")

    it "should not fail without anchor", ->
      expect(-> @controller.activateTab()).not.toThrow

    it "should mark anchor as active", ->
      @controller.activateTab(@links[0])
      expect(@links[0]).toHaveClass("active-tab")

    describe "should de-activate previous tab", ->
      Given "the first tab is active", ->
        @controller.activateTab(@links[0])
      When "I activate a different tab", ->
        @controller.activateTab(@links[1])
      Then "The first tab should not be active", ->
        expect(@links[0]).not.toMatch /(^|\s)active-tab(\s|$)/
      Then "The activated tab should be active", ->
        expect(@links[1]).toHaveClass("active-tab")

    describe "should not activate unsupported element types", ->
      Given "I activate a supported element type", ->
        @controller.activateTab(@links[0])
      When "I try to activate an unsupported element type", ->
        @controller.activateTab(@lis[0])
      Then "the supported element type should be active", ->
        expect(@links[0]).toHaveClass("active-tab")
      Then "the un-supported element type should NOT be active", ->
        expect(@lis[0]).not.toMatch /(^|\s)active-tab(\s|$)/
      Then "this is a duplicate, to try out not.toHaveClass", ->
        expect(@lis[0]).not.toHaveClass("active-tab")

    describe "should fire onTabChange", ->
      Given -> @controller.activateTab(@links[0])
      Given ->
        @controller.onTabChange = (curr, prev) =>
          @actualPrevious = prev
          @actualCurrent = curr
      When -> @controller.activateTab(@links[1])
      Then -> expect(@links[0]).toEqual @actualPrevious
      Then -> expect(@links[1]).toEqual @actualCurrent