#!/usr/bin/env coffee
#
# Client Side code
#
# http = require "http"
net = require "net"
url = require "url"

halt = ->
  process.exit()

process.on 'SIGINT', ->
  console.log 'Got SIGINT.  Press Control-D to exit.'
  halt()

surl = '0.0.0.0:7000'
purl = url.parse surl

handle = (response) ->
  #return if response.statusCode is not 200
  console.log "Received -> #{response}"

connected = (data) ->


client = net.createConnection(7000) # assume localhost , '0.0.0.0')
client.addListener('connect', connected)
client.addListener('data', handle)
client.write("XXXXXXXXXXXXXXXXXXXXXXXX")
#client.end() # BYE


process.stdin.resume()
process.stdin.setEncoding 'utf8'

process.stdin.on 'data', (chunk) ->
  console.log "chunk #{chunk}"
  if chunk.match(/^end\n$/)
    console.log "Logoff.."
    client.end()
    halt()
  else
    process.stdout.write 'sending data -> ' + chunk
    client.write chunk

process.stdin.on 'end', ->
  process.stdout.write 'end'