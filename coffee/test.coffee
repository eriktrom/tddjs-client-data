module "group a",
  setup: ->
  teardown: ->

test "a basic test", -> # 3 specifies the number of asserts to expect, needed for synchronous callback
  value = "hello"
  deepEqual(value, "hello", "We expect the value to be true") # 1

test "a synchronous callback test", 2, ->
  calc = (x, operation) -> operation(x)
  result = calc 2, (x) ->
    ok(true, "calc() calls operation function")
    x * x
  equal(result, 4, "2 square equals 4")


module("group b")
asyncTest "asynchronous test: one second later", 1, ->
  setTimeout ->
    ok(true, "Passed and ready to resume")
    start()
  , 1000

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


# Better example of asyncTest
# asyncTest( "asynchronous test: video ready to play", 1, function() {
#   var $video = $( "video" );
#
#   $video.on( "canplaythrough", function() {
#     ok( true, "video has loaded and is ready to play" );
#     start();
#   });
# });