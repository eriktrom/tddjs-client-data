// Generated by CoffeeScript 1.6.1

tddjs.namespace("ajax").create = function() {
  var options, value, _i, _len;
  options = [
    function() {
      return new ActiveXObject("Microsoft.XMLHTTP");
    }, function() {
      return new XMLHttpRequest();
    }
  ];
  for (_i = 0, _len = options.length; _i < _len; _i++) {
    value = options[_i];
    try {
      return value();
    } catch (e) {

    }
  }
  return null;
};