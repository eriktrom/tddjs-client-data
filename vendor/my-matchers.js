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
// expect(x).toBeInstanceOf(Constructor)
// expect(x).toBeOfType('something')