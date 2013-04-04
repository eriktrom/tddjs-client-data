// Generated by CoffeeScript 1.6.1

(function() {
  var ajax;
  ajax = tddjs.ajax;
  module("Get Request", {
    setup: function() {
      return this.ajaxCreate = ajax.create;
    },
    teardown: function() {
      return ajax.create = this.ajaxCreate;
    }
  });
  test("it should define get method", function() {
    return ok(typeof ajax.get === "function");
  });
  test("it should throw error without url", function() {
    return throws(function() {
      return ajax.get();
    }, TypeError);
  });
  test("it should obtain an XMLHttpRequest object", function() {
    ajax.create = stubFn({
      open: function() {}
    });
    ajax.get("/url");
    return ok(ajax.create.called);
  });
  return test("it should call open with method, url, async flag", function() {
    var actual, url;
    actual = "hello";
    ajax.create = stubFn({
      open: function() {
        return actual = arguments;
      }
    });
    url = "/url";
    ajax.get(url);
    actual = Array.prototype.slice.call(actual);
    return deepEqual(actual, ["GET", url, true]);
  });
})();
