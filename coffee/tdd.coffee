tddjs = do ->
  namespace = (string) ->
    object = this
    levels = string.split(".")
    for level in levels
      if typeof object[level] is "undefined"
        object[level] = {}
      object = object[level]
    object

  namespace: namespace


do ->
  dom = tddjs.namespace("dom")
  addClassName = (element, cName) ->
    regexp = new RegExp("(^|\\s)#{cName}(\\s|$)")
    if element && !regexp.test(element.className)
      cName = "#{element.className} #{cName}"
      element.className = cName.replace(/^\s+|\s+$/g, "")

  removeClassName = (element, cName) ->
    r = new RegExp("(^|\\s)#{cName}(\\s|$)");
    if element
      cName = element.className.replace(r, " ");
      element.className = cName.replace(/^\s+|\s+$/g, "");

  dom.addClassName = addClassName
  dom.removeClassName = removeClassName