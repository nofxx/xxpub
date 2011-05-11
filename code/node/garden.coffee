
class @Pop
  constructor: (@name) ->


test = (hello) ->
  console.log "Arguments => #{arguments[0]}"
  console.log arguments.callee
  if true
    cool = 1
  else
    cool = 2
  arguments.callee



test "hi"
test()
test()()

foox = -> console.log "ha"



hi = -> [document.title, "hi"].join(": ")