util = require 'util'

require.paths.unshift('~/.npm')

for path in require.paths
  console.log path

class Foo
  constructor: (@name) ->

  items: [1,2,3]

  foo: (oi) -> @oi = oi

  oi: -> @oi

  myclass: -> @constructor.name.toLowerCase()

  other: -> "Other!"

  work_inside: -> "Result #{@other()} #{@items}"

f = new Foo
f.oi = "ha"

ff = new Foo
ff.oi = "ho"

kind_of = (o) -> Object.prototype.toString.call(o).slice(8, -1)
is_a = (t, o) -> o != undefined && o != null && kind_of(o) == t

console.log f.oi
console.log ff.oi
console.log "---------------"
console.log f.myclass()
console.log util.inspect Foo.prototype
console.log kind_of(5)
console.log kind_of("kd")
console.log is_a('Number', 5)
console.log f.work_inside()

