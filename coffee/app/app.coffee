# src/observable.js
tddjs.namespace("util")

do ->
  Observable = ->
    @observers = []
    return "undefined"
  

  addObserver = (observer) ->
    @observers.push(observer)


  tddjs.util.Observable = Observable
  Observable::addObserver = addObserver