nodersa = require 'node-rsa'
fs = require 'fs'

key = fs.readFileSync 'server.key'

privKey = new nodersa key

module.exports =
  signObj: (obj) ->
    signature = privKey.sign(obj, 'binary')
    obj.signature = signature
