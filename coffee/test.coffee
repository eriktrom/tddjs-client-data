test "a basic test", 3, -> # 3 specifies the number of asserts to expect, needed for synchronous callback
  # expect(3) # this also works for specifying number of expected assertions
  value = "hello"
  deepEqual(value, "hello", "We expect the value to be true") # 1

  calc = (x, operation) ->
    operation(x)

  result = calc(2, (x) ->
    ok(true, "calc() calls operation function") # 2, synchronous callback
    x * x
  )

  equal(result, 4, "2 square equals 4") # 3
# ok
# equal
# strictEqual
# deepEqual


# Better example of synchronous callback
# test( "a test", 1, function() {
#   var $body = $( "body" );
#
#   $body.on( "click", function() {
#     ok( true, "body was clicked!" );
#   });
#
#   $body.trigger( "click" );
# });