#!/usr/bin/env coffee
#
# Socket server
#
# http://dhotson.tumblr.com/post/634304174/node-js-chat-server-in-coffeescript
#
net = require('net')

log = (all...) ->
  for txt in all
    console.log txt

Array::remove = (element) ->
  for e, i in this when e is element
    return this.splice(i, 1)

class Client
  constructor: (stream) ->
    @stream = stream
    @name = null

clients = []

server = net.createServer((stream) ->
  client = new Client(stream)
  clients.push client

  stream.setTimeout 0
  stream.setEncoding "utf8"

  stream.addListener('connect', ->
    stream.write 'Welcome, enter your username:\n'
  )

  stream.addListener('data', (data) ->
    log "Received data -> #{data}"
    if client.name is null
      client.name = data.match /\S+/
      stream.write('===========\n')
      for c in clients when c isnt client
        c.stream.write(client.name + " has joined.\n")
      return

    matched = data.match /^\/(.*)/
    if matched and matched.length > 1
      command = matched[1]
      if command == 'users'
        for c in clients
          stream.write("- " + c.name + "\n")
      else if command == 'quit'
        stream.end()

      return

    for c in clients when c isnt client
      c.stream.write(client.name + ": " + data)
  )

  stream.addListener('end', ->
    clients.remove client

    for c in clients
      c.stream.write "#{client.name} has left.\n"

    stream.end()
  )
)

log "Starting server.."
log clients
server.listen 7000
