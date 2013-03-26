(->
  anchors = document.getElementByTagName("a")
  controller = Object.create(lightboxController)
  regexp = /(^|\s)lightbox(\s|$)/
  for anchor in anchors
    if regexp.test(anchors[i].className)
      ((anchor) ->
        anchor.onclick = ->
          controller.open(anchor)
          false
      )(anchors[i])
)()