express = require 'express'
webpack = require 'webpack'
webpackDevMiddleware = require 'webpack-dev-middleware'
http = require 'http'


module.exports =
  run: (shareDB) ->
    app = express!

    app.use webpackDevMiddleware webpack require './webpack-config.ls'

    app.get '/', (req, res) ->
      res.render 'main'

    app.set 'view engine', 'pug'
    app.set 'views', __dirname

    server = http.createServer app
    io = (require 'socket.io')(server)
    io.on 'connection', (socket) ->
      console.log 'connected'
      socket.emit 'update', shareDB
      socket.on 'feUpdate', (data) ->
        shareDB.floors = data.floors
        socket.emit 'update', shareDB
      shareDB.eventEmitter.on 'update', (data) ->
        console.log 'update event received from db. emitting on socket'
        socket.emit 'update', data

    server.listen(8000)
