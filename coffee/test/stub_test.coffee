do ->
  module "Function::bind"
  # TODO - these tests don't test much, their just for my learning
  test "it is defined", ->
    ok(Function::bind isnt undefined)
    ok(typeof Function::bind is "function")

do ->
  matchers = tddjs.util.matchers

  module "Object#create"
  test "it is defined", ->
    ok(Object.create isnt "undefined")
    # ^^ whats the difference? below prints ok(Object.create !== void 0);
    ok(Object.create isnt undefined)
    ok(typeof Object.create is "function")
    matchers.okFunction(Object.create)

    # aFunction = new Function()
    # ok( Object.create instanceof aFunction )
    # ^^ the above throws a wierd error:
    # TypeError: Expecting a function in instanceof check, but got function create() { [native code] }