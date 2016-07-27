express = require 'express'
webpack = require 'webpack'
webpackDevMiddleware = require 'webpack-dev-middleware'


app = express()
app.listen 8000

app.use webpackDevMiddleware(webpack require './webpack.config')

app.get '/', (req, res) ->
  res.render 'main'

app.set 'view engine', 'pug'
app.set 'views', __dirname
