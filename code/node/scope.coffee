log = (args...) ->
  for txt in args
    console.log txt
log "Starting..."

globs = "global"
other = "other"

please = ->
  funcvar = "please !"
  globs = "ops.."

  log globs

  lonely = ->
    another = "haha"


log "globs -> #{globs}"
log "other -> #{other}"

class Deep
  constructor: (@reply) ->

  ask: -> "Reply #{@reply} and #{other()}"

  globs: -> "Dont overwrite?"

  other = -> "Overwrite!"


log "globs -> #{globs}"
log "other -> #{other}"


deep_obj =
  answer: 42
  question: -> this.answer

nada = -> this

log deep_obj.question()

please()


d = new Deep 100
log d.ask()
d = new Deep 200
log d.ask()
# log d.other() # no meth..
#
# f = nada()
# log f, nada#, this
#
#
# Create a scope for var key! do (key) ->
list = [1,8,9]
flist = []

for key in list
  do (key) ->
    flist.push () ->
      "Hi from #{key}"

console.log flist[0]()

console.log "FINITO"

outer =
  name: 'outer'
  outer_f: () ->
    self = @
    inner =
      name: 'inner'
      inner_f: () ->
        console.log "self.name: #{self.name}"
        console.log "@name: #{@name}"
    inner.inner_f()
    console.log(@name)
outer.outer_f()
