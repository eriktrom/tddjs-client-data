beforeEach(function() {
  this.addMatchers({


    // returns true whenever the internal [[Prototype]] property of
    // of a, or one of the objects on its prototype chain, is the same
    // object as b.prototype, pg 132 tddjs.com book
    toBeInstanceOf: function(Constructor) {
      // a instanceof b
      return this.actual instanceof Constructor;
    },

    toBeOfType: function(type) {
      return typeof this.actual === type;
    },

  });
});


// jasmine.Env.prototype.contains_ = function(haystack, needle) {
//   if (jasmine.isArray_(haystack)) {
//     for (var i = 0; i < haystack.length; i++) {
//       if (this.equals_(haystack[i], needle)) return true;
//     }
//     return false;
//   }
//   return haystack.indexOf(needle) >= 0;
// };



// currently available matcher list

// from Jasmine core
// The 'toBe' matcher compares with ===
// The 'toEqual' matcher
  // works for simple literals and variables
  // should work for objects
// The 'toMatch' matcher is for regular expressions
// The 'toBeDefined' matcher compares against `undefined`
// The `toBeUndefined` matcher compares against `undefined`
// The 'toBeNull' matcher compares against null
// The 'toBeTruthy' matcher is for boolean casting testing
// The 'toBeFalsy' matcher is for boolean casting testing
// The 'toContain' matcher is for finding an item in an Array
// The 'toBeLessThan' matcher is for mathematical comparisons
// The 'toBeGreaterThan' is for mathematical comparisons
// The 'toBeCloseTo' matcher is for precision math comparison
// The 'toThrow' matcher is for testing if a function throws an exception

// From jasmine-jquery
// toBe(jQuerySelector)
//   expect($('<div id="some-id"></div>')).toBe('div#some-id')
// toBeChecked()
// toBeEmpty()
// toBeHidden()
//   They have a CSS display value of none.
//   They are form elements with type equal to hidden.
//   Their width and height are explicitly set to 0.
//   An ancestor element is hidden, so the element is not shown on the page.
// toHaveCss(css)
//   expect($('<div style="display: none; margin: 10px;"></div>')).toHaveCss({display: "none", margin: "10px"})
// toBeSelected()
// toBeVisible()
//   Visible elements have a width or height that is greater than zero
// toContain(jQuerySelector)
//   expect($('<div><span class="some-class"></span></div>')).toContain('span.some-class')
// toExist()
// toHaveAttr(attributeName, attributeValue)
//   attribute value is optional, if omitted it will check only if attribute exists
// toHaveProp(propertyName, propertyValue)
//   property value is optional, if omitted it will check only if property exists
// toHaveBeenTriggeredOn(selector)
//   if event has been triggered on selector (see "Event Spies", below)
// toHaveBeenTriggered()
//   if event has been triggered on selector (see "Event Spies", below)
// toHaveBeenPreventedOn(selector)
//   if event has been prevented on selector (see "Event Spies", below)
// toHaveBeenPrevented()
//   if event has been prevented on selector (see "Event Spies", below)
// toHaveClass(className)
//   expect($('<div class="some-class"></div>')).toHaveClass("some-class")
// toHaveData(key, value)
//   value is optional, if omitted it will check only if an entry for that key exists
// toHaveHtml(string)
//   expect($('<div><span></span></div>')).toHaveHtml('<span></span>')
// toContainHtml(string)
//   expect($('<div><ul></ul><h1>header</h1></div>')).toContainHtml('<ul></ul>')
// toHaveId(id)
//   expect($('<div id="some-id"></div>')).toHaveId("some-id")
// toHaveText(string)
//   expect($('<div>some text</div>')).toHaveText('some text')
// toHaveValue(value)
//   only for tags that have value attribute
//   expect($('<input type="text" value="some text"/>')).toHaveValue('some text')
// toBeDisabled()
//   expect('<input type='submit' disabled='disabled'/>').toBeDisabled()
// toBeFocused()
//   expect($('<input type='text' />').focus()).toBeFocused()
// toHandle(eventName)
//   expect($form).toHandle("submit")
// toHandleWith(eventName, eventHandler)
//   expect($form).toHandleWith("submit", yourSubmitCallback)

// jasmine-jquery HTML Fixtures
//   In HTML Fixture File
//     myfixture.html
//       By default, fixtures are loaded from spec/javascripts/fixtures
//       You can configure this path: jasmine.getFixtures().fixturesPath = 'my/new/path';
//   In your tests
//     loadFixtures('myfixture.html')
//     $('#my-fixture').myTestedPlugin();
//     expect($('#my-fixture')).to...;
//
//   Notes on Fixtures:
//     Your fixture is being loaded into <div id="jasmine-fixtures"></div> container
//     that is automatically added to the DOM by the Fixture module (If you REALLY
//     must change id of this container, try: jasmine.getFixtures().containerId =
//     'my-new-id'; in your test runner). To make tests fully independent, fixtures
//     container is automatically cleaned-up between tests, so you don't have to
//     worry about left-overs from fixtures loaded in preceeding test. Also, fixtures
//     are internally cached by the Fixture module, so you can load the same fixture
//     file in several tests without penalty to your test suite's speed.
//
//     jasmine.getFixtures().load(...);
//     IS ALIASED AS
//     loadFixtures(...);
//
// FIXTURE Methods(they each have an alias, listed below full name)
//
// jasmine.getFixtures().load(fixtureUrl[, fixtureUrl, ...])
// loadFixtures(fixtureUrl[, fixtureUrl, ...])
//   Loads fixture(s) from one or more files and automatically appends them to the DOM (to the fixtures container)
//
// jasmine.getFixtures().appendLoad(fixtureUrl[, fixtureUrl, ...])
// appendLoadFixtures(fixtureUrl[, fixtureUrl, ...])
//   Same as load, but adds the fixtures to the pre-existing fixture container.
//
// jasmine.getFixtures().read(fixtureUrl[, fixtureUrl, ...])
// readFixtures(fixtureUrl[, fixtureUrl, ...])
//   Loads fixture(s) from one or more files but instead of appending them to the
//   DOM returns them as a string (useful if you want to process fixtures content directly in your test).
//
// jasmine.getFixtures().set(html)
// setFixtures(html)
//   Doesnt load fixture from file, but instead gets it directly as a parameter
//   (html parameter may be a string or a jQuery element, so both
//   set('<div></div>') and set($('<div/>')) will work). Automatically appends
//   fixture to the DOM (to the fixtures container). It is useful if your fixture
//   is too simple to keep it in an external file or is constructed procedurally,
//   but you still want Fixture module to automatically handle DOM insertion and
//   clean-up between tests for you.
//
// jasmine.getFixtures().appendSet(html)
// appendSetFixtures(html)
//   Same as set, but adds the fixtures to the pre-existing fixture container.
//
// jasmine.getFixtures().preload(fixtureUrl[, fixtureUrl, ...])
//   Pre-loads fixture(s) from one or more files and stores them into cache,
//   without returning them or appending them to the DOM. All subsequent calls to
//   load or read methods will then get fixtures content from cache, without making
//   any AJAX calls (unless cache is manually purged by using clearCache method).
//   Pre-loading all fixtures before a test suite is run may be useful when working
//   with libraries like jasmine-ajax that block or otherwise modify the inner
//   workings of JS or jQuery AJAX calls.
//
// Sandbox - A helper method for creating HTML elements for your tests:
//
// sandbox([{attributeName: value[, attributeName: value, ...]}])
//   It creates an empty DIV element with a default id="sandbox". If a hash of
//   attributes is provided, they will be set for this DIV tag. If a hash of
//   attributes contains id attribute it will override the default value. Custom
//   attributes can also be set.
//
//   Examples:
//   1.
//     sandbox();
//     # =>
//     <div id="sandbox"></div>
//
//   2.
//     sandbox({
//       id: 'my-id',
//       class: 'my-class',
//       myattr: 'my-attr'
//     });
//     # =>
//     <div id="my-id" class="my-class" myattr="my-attr"></div>
//
//   3. Useful to quickly create simple fixtures in your tests without polluting
//      them with html strings
//
//      setFixtures(sandbox({class: 'my-class'}));
//      $('#sandbox').myTestedClassRemoverPlugin();
//      expect($('#sandbox')).not.toHaveClass('my-class');
//
//   Global Shortcut:
//     sandbox([{attributeName: value[, attributeName: value, ...]}])
//
//   Cleanup Methods: (no global shortcuts for these)
//     clearCache()
//       purges Fixture module internal cache (you should need it only in very special
//       cases; typically, if you need to use it, it may indicate a smell in your test
//       code)
//     cleanUp()
//       cleans-up fixtures container (this is done automatically between tests by
//       Fixtures module, so there is no need to ever invoke this manually, unless
//       youre testing a really fancy special case and need to clean-up fixtures in
//       the middle of your test)
//
// Style Fixtures: Read Docs - theyre css fixtures you can use to change styling of a fixture
// JSON Fixtures: Read Docs - Allows you to load JSON data from a file
//
// Event Spies: Read Docs, heres quick example, also read http://luizfar.wordpress.com/2011/01/10/testing-events-on-jquery-objects-with-jasmine/
// var spyEvent = spyOnEvent('#some_element', 'click');
// $('#some_element').click();
// expect('click').toHaveBeenTriggeredOn('#some_element');
// expect(spyEvent).toHaveBeenTriggered();

// From jasmine-matchers-1.1.0
//
// expect(x).toBeArray();
// expect(x).toBeArrayOfSize(number);
//
// expect(x).toBeTrue();
// expect(x).toBeFalse();
// expect(x).toBeBoolean();
//
// expect(x).toBeWindow();
// expect(x).toBeDocument();
// expect(x).toBeHtmlCommentNode();
// expect(x).toBeHtmlNode();
// expect(x).toBeHtmlTextNode();
//
// expect(fn).toThrowError();
// expect(fn).toThrowErrorOfType('TypeError');
//
// expect(x).toBeNumber();
// expect(x).toBeCalculable();
// expect(x).toBeEvenNumber();
// expect(x).toBeOddNumber();
//
// expect(x).toBeFunction();
// expect(x).toBeObject();
// expect(object).toImplement(api);
//
// expect(x).toBeNonEmptyString();
// expect(x).toBeString();
// expect(x).toBeHtmlString();
// expect(x).toBeWhitespace();
//
//

// My own matchers, mostly ripped from matchers.js
// expect(x).toBeInstanceOf(Constructor)
// expect(x).toBeOfType('something')