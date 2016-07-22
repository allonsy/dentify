require! {
  'express' : express
  'fs' : fs
  'https': https
}

app = express!

app.get '/', (req, res) ->
  res.send 'Hello World'

options =
  key: fs.readFileSync 'server.key'
  cert: fs.readFileSync 'cert.crt'
  secureProtocol: 'TLSv1_2_method'

https.createServer(options, app).listen 3000
