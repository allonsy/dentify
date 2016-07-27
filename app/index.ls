require! {
  'async'
  'chalk' : {cyan, dim, green, red}
  'express'
  'fs'
  'nitroglycerin' : N
  'pg'
  'tls'
  './web-server' : WebServer
}


start-web-server = (done) ->
  web-server = new WebServer
    ..on 'error', (err) -> console.log red err
    ..on 'listening', ->
      console.log "#{green 'HTML server'} online at port #{cyan web-server.port!}"
      done!
    ..listen 8000


query-database = (query) ->
  client.connect (err) ->
    if err
      return
    client.query query, (err ,result) ->
      console.log result.rows
      client.end (err) ->
        if err
          return


start-tls-server = (done) ~>
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
    done!



client = new pg.Client!
start-web-server N ->
  start-tls-server N ->
    console.log green 'All systems go'
