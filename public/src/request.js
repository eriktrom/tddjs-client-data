// Generated by CoffeeScript 1.6.1

(function() {
  var ajax, get;
  ajax = tddjs.namespace("ajax");
  get = function(url) {
    var transport;
    if (typeof url !== "string") {
      throw new TypeError("URL should be string");
    }
    transport = tddjs.ajax.create();
    transport.open("GET", url, true);
  };
  return ajax.get = get;
})();
