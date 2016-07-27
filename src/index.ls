require! {
  'express'
  'fs' : fs
  'tls' : tls
  'jade'
  'path'
  'pg' : pg
  './controllers/home': HomeController
}

options =
  key: fs.readFileSync 'server.key'
  cert: fs.readFileSync 'server.crt'
  secureProtocol: 'TLSv1_2_method'
  requestCert: true
  rejectUnauthorized: false

server = tls.createServer options, (socket) ->
  console.log 'connected to user'
  console.log socket.getPeerCertificate()

server.listen 3000 ->
  console.log 'listening on port 3000'

client = new pg.Client();

# connect to our database (uses evironment parameters to connect to local db)
client.connect (err) ->
  if err then return

  # execute query
  client.query 'SELECT * FROM users', (err ,result) ->
    console.log result.rows

    # disconnect the client
    client.end (err) ->
      if err then return

app = express!
  ..set 'views', (path.join __dirname, 'views')
  ..set 'view engine', 'jade'
  ..get '/', HomeController.index
  ..listen 8000 ->
    console.log "HTTP server listening at port 8000"