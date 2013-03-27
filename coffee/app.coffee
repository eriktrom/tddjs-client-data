do ->
  dom = tddjs.dom
  create = (element) ->
    if !element || typeof element.className != "string"
      throw new TypeError("element is not an element")

    dom.addClassName(element, "js-tab-controller")
    tabs = Object.create(this)

    element.onclick = (event) ->
      tabs.handleTabClick(event || window.event || {})

    element = null
    tabs

  handleTabClick = (event) ->

  tddjs.namespace("ui").tabController =
    create: create
    handleTabClick: handleTabClick
