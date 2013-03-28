# test/observable_test.js
# describe "Observable", ->
#   describe "addObserver", ->
#     it "should store function", ->
#       observable = new tddjs.util.Observable()
#       observer = ->

#       observable.addObserver(observer)

#       expect(observable.observers[0]).toEqual observer

test "Observable#addObserver should store function", ->
  observable = new tddjs.util.Observable()
  observer = ->

  strictEqual(observer, observable.observers[0]) 