// Generated by CoffeeScript 1.6.1

(function() {
  var Observable;
  module("Observable");
  Observable = function() {};
  return test("add observer to observable", function() {
    var observable;
    observable = new Observable();
    observable.addObserver(observerDbl);
    ok(observable.observers[0] === observerDbl);
    return ok(observable.observers.length === 1);
  });
})();
