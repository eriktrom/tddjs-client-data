// Generated by CoffeeScript 1.6.1

(function() {
  var ajax;
  ajax = tddjs.ajax;
  return module("Ajax Create", test("it should return XMLHttpRequest object", function() {
    var xhr;
    xhr = ajax.create();
    tddjs.util.matchers.okNumber(xhr.readyState);
    ok(tddjs.isHostMethod(xhr, "open"));
    ok(tddjs.isHostMethod(xhr, "send"));
    return ok(tddjs.isHostMethod(xhr, "setRequestHeader"));
  }));
})();
