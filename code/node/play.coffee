#
#
# Playing with coffee !
#
#
# Emacs Keys:
#
#   M-p  compile-run
#   M-l  compile-show
#
#
sys = require 'sys'
util = require 'util'

alert = (txt) ->
  sys.puts txt

log = (args...) ->
  for txt in args
    alert txt

puts = (objs...) ->
  for o in objs
    console.log util.inspect(o)

alert "start"

foo = 10
fox = 0x10
foc = 077 # AVOID
fof = 1.34e-23
i = Infinity
t = "txt"
soff = Math.sin(foc)

log fox, foc, soff

if isNaN foo
  log "Foo NaN"
else if foo < 11
  log "foo less 10"
else
  log "Foo is > 11"

if isFinite foo
  log "Foo is finite"

sys.puts "Oie"

# Assignment:
number   = 42
opposite = true

# Conditions:
number = -42 if opposite

log foc.toString 2
log foc.toFixed 2
log parseFloat("0.30") + 2
# Functions:
square = (x) -> x * x

log (0x1234 & 0x00FF).toString(16)

aa = undefined
a = [] if (!aa)

log typeof "foo"
log typeof 5
log typeof [] #obj
log a instanceof Array

# Strings
#
log " ----------------------------------------- Strings"
phrase = "Nice colorful razor weed"
log phrase[20]

log txt = "Pretty nice #{foo} var"

log "Txt size is #{txt.length}"

#
# Objects
#
log " ----------------------------------------- Objects"
n = new Date
r = new RegExp("\\sjava\\s", "i");

p = new Object
p.x = 10
p.toString = -> "I'm object #{this.x}"

log n, util.inspect(p)
log p.x
log p["x"]

p1 =
  x: 10
  toString: -> "Another obj #{this.x}"

log p1, util.inspect(p1)

foo = "x" of p
log foo
foo = "toString" in p
log foo

log typeof p

for v of p1
  log "var name: #{v} value: #{p[v]}"

#
# Arrays
#
log " ----------------------------------------- Arrays"

a = new Array
aa = new Array 1.2, "foo", true, null
list = [1, 2, 3, 4, 5]
a[0] = 10
a[5] = 15
a[3] = { x: 1, y: 2 }
a.push 29

log util.inspect(a)

multi = [[1,2,3], [4,5,6]]
log multi.join()

for x in multi
  for y in x
    ala = y


#
# Functions
#
log " ----------------------------------------- Functions"

# Objects:
math =
  root:   Math.sqrt
  square: square
  cube:   (x) -> x * square x

# Splats:
race = (winner, runners...) ->
  print winner, runners

# Existence:
alert "I knew it!" if elvis?

# Array comprehensions:
cubes = (math.cube num for num in list)


sys.puts "Foo.."
console.log "Fighters?"

#
# Classes
#
log " ----------------------------------------- Classes"

class Foo
  constructor: (@name, x) ->
    @xx = x

  # Instance method
  test: (txt) ->
    alert "Name: #{@name} #{txt} x #{@xx}"
  # WRONG!
  # otro = (x) -> x * 2

  valueOf: -> @xx

  compareTo: (other) ->
    throw new Error("bad arguments to compare") if !other || !other.xx
    @xx - other.xx

# Class vars
Foo.XXX = "Booze?"

# Class methods
Foo.max = (a, b) ->
  if a > b then a else b

f = new Foo "ho", 2
f1 = new Foo "ho", 10
f.test "hey"

# Cool trick
log f.compareTo(f1) < 0

# Uses valueOf
log if f1 > f then "F1 wins" else "F1 loose"

log "Foomax: #{Foo.max(8,1)}"

class Rock extends Foo
  otro: ->
    alert "Hey #{@name}"


r = new Rock "jo"
r.test "haha"
r.otro


class @Mxx
  constructor: (@attr) ->

  attr: (attr) ->
    @attr = attr


x = new @Mxx 10
x1 = new @Mxx 20

x.attr = 30


puts x, x1


