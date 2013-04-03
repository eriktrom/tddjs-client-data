tddjs.namespace("util")

do ->
  # `
  # function Observable() {

  # }

  # function addObserver(observer) {
  #   this.observers = [observer]
  # }
  # `

  Observable = ->

  addObserver = (observer) ->
    @observers = [observer]

  Observable::addObserver = addObserver


  tddjs.util.Observable = Observable
  return