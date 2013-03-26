# describe "Array#splice", ->
#   it "should return removed items", ->
#     arr = [1, 2, 3, 4, 5]
#     result = arr.splice(2, 3)
#     expect(result).toEqual([3, 4, 5])


# describe "Function#length property", ->
#   it "does something", ->
#     expect(document.getElementById.length).toBe(1)
#     expect(console.log.length).toBe(0)

# describe "the arguments object", ->
#   # modify = null
#   beforeEach ->
#     @modify = (a, b) ->
#       b = 42
#       arguments[0] = arguments[1]
#       a
#
#   it "shares a dynamic relationship with formal parameters", ->
#     # changing a property of the arguments object causes the corresponding
#     # formal parameter to change and vice versa
#     expect(@modify(1, 2)).toEqual(42)
#
#   it "returns undefined for missing default params", ->
#     expect(@modify(1)).toBeUndefined

# global = this
# describe "Global Object Test", ->
#   describe "window object", ->
#     it "is === to global object", -> expect(window).toBe global
#     it "is === to global.window", -> expect(window).toBe global.window
#     it "is === to window.window", -> expect(window).toBe window.window

describe "adder", ->
  Given ->    
    @inc = adder(1)
    @dec = adder(-1)

  Then -> expect(@inc(2)).toEqual 3
  Then -> expect(@dec(4)).toEqual 3
  Then -> expect(@inc(@dec(3))).toEqual 3