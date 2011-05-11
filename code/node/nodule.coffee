
vows = require 'vows'
assert = require 'assert'
_ = require 'underscore'

puts = (txt) -> console.log txt

puts "Starting..."

_.map([1,2,3], (i) -> puts "I -> #{i}")

sum = (a, b) -> a + b

vows_callback = (txt) ->
  puts "Callback vows"
  puts txt

vows.describe('Math')
  .addBatch
    'when creating a new point with x and y':
      topic: -> sum 1, 1

      'I get 1 for x': (topic) ->
        assert.equal topic, 2

    'but when dividing zero be zero':
      topic: -> 0 / 0

      'we get a value which':
        'is not a number': (topic) ->
          assert.isNaN topic

        'is not equal to itself': (topic) ->
          assert.notEqual topic, topic
  .run(vows_callback)