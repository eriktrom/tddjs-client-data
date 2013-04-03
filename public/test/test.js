// Generated by CoffeeScript 1.6.1

module("Observable#observe", {
  setup: function() {
    return this.observable = Object.create(tddjs.util.observable);
  }
});

test("it adds observers", function() {
  var observers;
  observers = [(function() {}), (function() {})];
  this.observable.observe("event", observers[0]);
  this.observable.observe("event", observers[1]);
  deepEqual(this.observable.observers, observers);
  ok(this.observable.hasObserver(observers[0]));
  return ok(this.observable.hasObserver(observers[1]));
});

module("Observable#hasObserver", {
  setup: function() {
    return this.observable = Object.create(tddjs.util.observable);
  }
});

test("it returns true when it has observer(s)", function() {
  var observer;
  observer = function() {};
  this.observable.observe("event", observer);
  return ok(this.observable.hasObserver(observer));
});

test("it returns false when it has no observer(s)", function() {
  return ok(!(this.observable.hasObserver(function() {})));
});

module("Observable#notify", {
  setup: function() {
    return this.observable = Object.create(tddjs.util.observable);
  }
});

test("it calls all observers", function() {
  var observer1, observer2;
  observer1 = function() {
    return observer1.called = true;
  };
  observer2 = function() {
    return observer2.called = true;
  };
  this.observable.observe("event", observer1);
  this.observable.observe("event", observer2);
  this.observable.notify();
  ok(observer1.called);
  return ok(observer2.called);
});

test("it should pass through arguments", function() {
  var actual;
  actual = null;
  this.observable.observe("event", function() {
    return actual = arguments;
  });
  this.observable.notify("String", 1, 32);
  return deepEqual(Array.prototype.slice.call(actual, 0), ["String", 1, 32]);
});

test("it should throw for uncallable observer", function() {
  return throws(function() {
    return this.observable.observe("event", {});
  }, TypeError);
});

test("it should notify all even when some fail", function() {
  var observer1, observer2;
  observer1 = function() {
    throw new Error("Oops");
  };
  observer2 = function() {
    return observer2.called = true;
  };
  this.observable.observe("event", observer1);
  this.observable.observe("event", observer2);
  this.observable.notify();
  return ok(observer2.called);
});

test("it should call observers in the order they were added", function() {
  var calls, observer1, observer2;
  calls = [];
  observer1 = function() {
    return calls.push(observer1);
  };
  observer2 = function() {
    return calls.push(observer2);
  };
  this.observable.observe("event", observer1);
  this.observable.observe("event", observer2);
  this.observable.notify();
  ok(observer1 === calls[0]);
  return ok(observer2 === calls[1]);
});

test("it should not fail if no observers", function() {
  return ok(!(this.observable.notify()));
});
