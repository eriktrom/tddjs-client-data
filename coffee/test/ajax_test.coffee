module "Ajax Create"

test "it should return XMLHttpRequest object", ->
  xhr = tddjs.ajax.create()

  tddjs.util.matchers.okNumber(xhr.readyState)
  ok(tddjs.isHostMethod(xhr, "open"))
  ok(tddjs.isHostMethod(xhr, "send"))
  ok(tddjs.isHostMethod(xhr, "setRequestHeader"))