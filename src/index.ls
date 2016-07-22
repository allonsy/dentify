require! {
  'express' : express
  'fs' : fs
  'https': https
}

app = express!

options =
  key: fs.readFileSync 'server.key'
  cert: fs.readFileSync 'server.crt'
  secureProtocol: 'TLSv1_2_method'

https.createServer(options, app).listen 3000

app.get '/', (req, res) ->
  res.send 'Hello World'
