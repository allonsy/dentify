express = require 'express'
webpack = require 'webpack'
webpackDevMiddleware = require 'webpack-dev-middleware'
http = require 'http'


module.exports =
  run: (shareDB) ->
    app = express!
    app.listen 8000

    app.use webpackDevMiddleware webpack require './webpack-config.ls'

    app.get '/', (req, res) ->
      res.render 'main'

    app.set 'view engine', 'pug'
    app.set 'views', __dirname

    server = http.createServer app
    io = (require 'socket.io')(server)
    io.on 'connection', (socket) ->
      console.log 'connected'
      shareDB.eventEmitter.on 'update', (data) ->
        socket.emit 'update', data

    # server.listen(3000)
