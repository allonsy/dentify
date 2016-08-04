require! {
  'async'
  'chalk' : {cyan, dim, green, red}
  'fs'
  'tls'
  './handler' : handler
  'node-rsa' : nodersa
  './signature': signature
  'socket.io': io
}

key = fs.readFileSync 'server.key'

module.exports =
  run: (shareDb) ->

    options =
      key: key
      cert: fs.readFileSync 'server.crt'
      ca: fs.readFileSync 'ca.crt'
      secureProtocol: 'TLSv1_2_method'
      requestCert: true
      rejectUnauthorized: true

    tls-server = tls.create-server options, (socket) ->
      if not socket.authorized
        socket.end!
      socket.on 'data', (data) ->
        try
          dataStr = data.toString 'utf8'
          jsonData = JSON.parse dataStr
          resp = handler.handleJson jsonData, socket.getPeerCertificate!.subject.CN, shareDb
          signature.signObj(resp)
          socket.write(JSON.stringify(resp) + '\r\n')
        catch err
          console.log 'unable to parse json: ' + dataStr
          console.log 'error is: ' + err
          socket.write((JSON.stringify {success:false, error: 'Please send valid JSON'}) + '\r\n')
        finally
          socket.end!

    tls-server.listen 3000 ->
      console.log "#{green 'TLS server'} online at port #{cyan '3000'}"
      console.log green 'All systems go'
