coffee = require('iced-coffee-script/register') # register compiler with nodejs

#assert = require('assert')
assert = require('chai').assert
expect = require('chai').expect
should = require('chai').should()

sinon = require('sinon')

# mocha
describe 'Array', ->
  describe '#indexOf()', ->
    it 'should return -1 when the value is not present', ->
      assert.equal -1, [ 1, 2, 3 ].indexOf(5)
      assert.equal -1, [ 1, 2, 3 ].indexOf(5)
      return
    return
  return

# chai (with mocha)
foo = 'bar'
describe 'String', ->
  describe '#string', ->
    it 'should be a string', ->
      foo.should.be.a('string')
      return
    return
  return

# sinon (with chai & mocha)

# The "mock"...
# The following function takes a function as its argument and returns a new function. 
# You can call the resulting function as many times as you want, but the original
# function will only be called once:

once = (fn) ->
  returnValue = undefined
  called = false
  return () ->
    if !called
      called = true
      returnValue = fn.apply(this, arguments)
    returnValue

describe 'Mocking', ->
  describe '#called', ->
    it 'calls the original functione', ->
      callback = sinon.spy();
      proxy = once(callback);

      proxy();

      assert(callback.called);
  describe '#calledonce', ->
    it 'calls the original function only once', ->
      callback = sinon.spy();
      proxy = once(callback);

      proxy();
      proxy();

      assert(callback.calledOnce);
      # ...or:
      # assert.equals(callback.callCount, 1);