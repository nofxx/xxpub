# Setup
sweet = exports

# Classless
# sweet.calc = (a, b) -> a - b
# sweet.hi = (name) -> "#{internal_work()} #{name}"
internal_work = -> "Hi"

class Candy
  constructor (@lvl) ->

  sweetness: ->  10

  calc: (a, b) -> a - b

  hi: (name) -> "#{internal_work()} #{name}"

module.exports = Candy