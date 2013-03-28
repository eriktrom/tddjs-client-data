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
    # no tests for this yet, just explanation. Tests come in chapter 10
    # grab element that triggered the event
    # this means the target property of the event object in most browsers
    # IE uses srcElement
    target = event.target || event.srcElement
    # accomodate browsers that occasionally fire events directly on text
    # nodes, make sure it got an element node
    while target && target.nodeType != 1
      target = target.parentNode
    @activateTab(target)

  activateTab = (element) ->
    return if !element ||
              !element.tagName ||
              element.tagName.toLowerCase() != @tabTagName
    className = 'active-tab'
    dom.removeClassName(@prevTab, className)
    dom.addClassName(element, className)
    previous = @prevTab
    @prevTab = element
    @onTabChange(element, previous)

  tddjs.namespace("ui").tabController =
    create: create
    handleTabClick: handleTabClick
    activateTab: activateTab
    onTabChange: (anchor, previous) ->
    tabTagName: "a"
