do ->
  matchers = tddjs.namespace("util").matchers

  module "Matchers Test"

  test "okNumber", ->
    ok matchers.okNumber(10)

  test "okFunction", ->
    ok matchers.okFunction(->)

  test "okObject", ->
    ok matchers.okObject({})

do ->
  matchers = tddjs.namespace("util").matchers

  module "stubFn()",
    setup: -> @someStub = stubFn()

  test "it returns a function", ->
    ok matchers.okFunction(@someStub)

  test "called property is false when stubbed function is not called", ->
    ok @someStub.called is false

  test "called property is true when stubbed function is called", ->
    @someStub()
    ok @someStub.called

  test "args property contains args called on stubbed function", ->
    @someStub('beat it')
    ok @someStub.args[0] is 'beat it'
    ok @someStub.args.length is 1

  test "will return original returnValue", -> #TODO: terrible description
    mrStubby = stubFn({sex: 'male'})
    deepEqual mrStubby(), {sex: 'male'}

  test "returned function can be called multiple times with its own args", ->
    @someStub('beat it')
    ok @someStub.args[0] is 'beat it'

    @someStub('but i just want to be friends')
    ok @someStub.args[0] is 'but i just want to be friends'

    @someStub('no you cant', 'yes i can')
    ok @someStub.args.length is 2

    ok @someStub.args[0] isnt 'beat it'

do ->
  matchers = tddjs.namespace("util").matchers
  module "XMLHttpRequestDbl Test",
    setup: -> @subject = XMLHttpRequestDbl
  test "#open", ->
    ok @subject.hasOwnProperty('open')
    ok matchers.okFunction(@subject.open)
  test "#send", ->
    ok @subject.hasOwnProperty('send')
    ok matchers.okFunction(@subject.send)
  test "#readyStateChange", ->
    ok @subject.hasOwnProperty('readyStateChange')
    ok matchers.okFunction(@subject.readyStateChange)
    # ok @subject is aCallback
  test "#setRequestHeader", ->
    ok @subject.hasOwnProperty('setRequestHeader')
    ok matchers.okFunction(@subject.setRequestHeader)
    # ok @subject is aCallback
  test "#complete", ->
    ok @subject.hasOwnProperty('complete')
    ok matchers.okFunction(@subject.complete)
    # ok @subject is aCallback

do ->
  matchers = tddjs.namespace("util").matchers
  testHelpers = tddjs.namespace("util").testHelpers

  module "forceStatusAndReadyState"

  test "it is a function", ->
    subject = testHelpers.forceStatusAndReadyState
    ok matchers.okFunction(subject)

do ->
  # TODO: write tests for global.stubDateConstructor
  module "global.stubDateConstructor"
