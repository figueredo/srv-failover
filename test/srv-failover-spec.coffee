{describe, it} = global
{expect} = require 'chai'

SrvFailover = require '../src/'

describe 'SrvFailover', ->
  describe '->constructor', ->
    describe 'when constructed without a service', ->
      it 'should error', ->
        expect(=> new SrvFailover {}).to.throw 'Missing required parameter: service'
