require! {
  'async'
  'chalk' : {cyan, dim, green, red}
  'fs'
  'tls'
}

module.exports =
  run: (shareDb) ->

    options =
      key: fs.readFileSync 'server.key'
      cert: fs.readFileSync 'server.crt'
      ca: fs.readFileSync 'ca.crt'
      secureProtocol: 'TLSv1_2_method'
      requestCert: true
      rejectUnauthorized: true

    @tls-server = tls.create-server options, (socket) ->
      console.log socket.getPeerCertificate!

    @tls-server.listen 3000 ->
      console.log "#{green 'TLS server'} online at port #{cyan '3000'}"
      console.log green 'All systems go'
