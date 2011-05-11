util = require('util')
mongoose = require('mongoose')
Schema = mongoose.Schema
ObjectId = Schema.ObjectId

# coll = mongoose.noSchema('lia', db)

mongoose.connect('mongodb://localhost/slia')


class Bobs
  constructor: (@name) ->
  persist: -> mongs


PplSchema = new Schema
  name:  { type: String, default: '' }
  age:   { type: Number, min: 18, index: true }
  bio:   { type: String, match: /[a-z]/ }
  date:  { type: Date, default: Date.now }

mongoose.model("Ppl", PplSchema);

Ppl = mongoose.model("Ppl")

p = new Ppl()

p.name = "testim"
p.age = 20
p.bio = "jdjdj"

p.save (err) ->
  if err
    console.log("Damn... #{err}")
  else
    console.log("yea")



Ppl.find {}, (err, docs) ->
  console.log "Hi! #{docs.length}"
  for doc in docs
    console.log util.inspect doc
    #console.log doc.age

# # coll.find({}).each (doc) ->
# #   console.log doc
#
# mongoose.close
console.log "Fim"
