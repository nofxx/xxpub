

events = require 'events'

emitter = new events.EventEmitter()

emitter.on "nuke", (message) ->
  console.log "NUKED!"



emitter.emit "nuke", "somewhere"