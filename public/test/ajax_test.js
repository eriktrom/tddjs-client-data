// Generated by CoffeeScript 1.6.1

module("Ajax Create");

test("it should return XMLHttpRequest object", function() {
  var xhr;
  xhr = tddjs.ajax.create();
  tddjs.util.matchers.okNumber(xhr.readyState);
  ok(tddjs.isHostMethod(xhr, "open"));
  ok(tddjs.isHostMethod(xhr, "send"));
  return ok(tddjs.isHostMethod(xhr, "setRequestHeader"));
});
