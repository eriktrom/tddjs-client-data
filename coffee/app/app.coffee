tddjs.namespace("util")

do ->
  Observable = ->

  addObserver = (observer) ->
    @observers = [observer]

  Observable::addObserver = addObserver

  tddjs.util.Observable = Observable