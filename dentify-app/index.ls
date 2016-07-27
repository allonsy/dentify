require! {
  'async'
  'chalk' : {cyan, dim, green, red}
  'fs'
  'tls'
  'nitroglycerin' : N
}


start-tls-server = (done) ~>
  certfile = fs.readFileSync 'server.crt'

  options =
    key: fs.readFileSync 'server.key'
    cert: certfile
    ca: certfile
    secureProtocol: 'TLSv1_2_method'
    requestCert: true
    rejectUnauthorized: false

  @tls-server = tls.create-server options, (socket) ->
    socket.get-peer-certificate!

  @tls-server.listen 3000 ->
    console.log "#{green 'TLS server'} online at port #{cyan '3000'}"
    done!


start-tls-server N ->
  console.log green 'All systems go'
