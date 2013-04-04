do ->
  ajax = tddjs.ajax

  module "Ajax Create",

  test "it should return XMLHttpRequest object", ->
    xhr = ajax.create()

    tddjs.util.matchers.okNumber(xhr.readyState)
    ok(tddjs.isHostMethod(xhr, "open"))
    ok(tddjs.isHostMethod(xhr, "send"))
    ok(tddjs.isHostMethod(xhr, "setRequestHeader"))

