do ->
  okNumber = (actual) ->
    !isNaN(parseFloat(actual)) and
    !(Object.prototype.toString.call(actual) is "[object Number]")

  tddjs.namespace("util").matchers = {
    okNumber
  }