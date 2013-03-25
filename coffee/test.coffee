module "TestCase"

test "array splice should return removed items", ->
  arr = [1, 2, 3, 4, 5]
  result = arr.splice(2, 3)
  deepEqual(result, [3, 4, 5])