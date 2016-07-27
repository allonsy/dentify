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


start-database = (done) ~>
  @client = new pg.Client()
    ..connect (err) ->
      if err
        console.log red "Database error"
        done!
      else
        console.log "#{green 'Database'} online"
        done!


# @client.query 'SELECT * FROM users', (err ,result) ->
#   console.log result.rows

#     # disconnect the client
# @client.end (err) ->
#   if err then return


start-tls-server = (done) ~>
  options =
    key: fs.readFileSync 'server.key'
    cert: fs.readFileSync 'server.crt'
    secureProtocol: 'TLSv1_2_method'
    requestCert: true
    rejectUnauthorized: false

  @tls-server = tls.create-server options, (socket) ->
    socket.get-peer-certificate!

  @tls-server.listen 3000 ->
    console.log "#{green 'TLS server'} online at port #{cyan '3000'}"
    done!



start-web-server N ->
  start-database N ->
    start-tls-server N ->
      console.log green 'All systems go'