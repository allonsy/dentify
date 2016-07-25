require! {
  'fs' : fs
  'tls' : tls
}

options =
  key: fs.readFileSync 'server.key'
  cert: fs.readFileSync 'server.crt'
  secureProtocol: 'TLSv1_2_method'

server = tls.createServer options, (socket) ->
  console.log socket.getPeerCertificate()

server.listen 3000 ->
  console.log 'listening on port 3000'
