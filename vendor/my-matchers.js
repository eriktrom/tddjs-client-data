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