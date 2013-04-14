do ->
  okNumber = (actual) ->
    !isNaN(parseFloat(actual)) &&
    !(Object.prototype.toString.call(actual) is "[object Number]")

  okFunction = (actual) ->
    Object::toString.call(actual) is "[object Function]" # pg. 191 js-definitive-guide

  okObject = (actual) ->
    Object::toString.call(actual) is "[object Object]"


  tddjs.namespace("util").matchers = {
    okNumber
    okFunction
    okObject
  }