describe "Array#splice", ->
  it "should return removed items", ->
    arr = [1, 2, 3, 4, 5]
    result = arr.splice(2, 3)
    expect(result).toEqual([3, 4, 5])