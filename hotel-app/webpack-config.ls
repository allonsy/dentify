path = require 'path'

module.exports =

  entry: path.join __dirname, 'client/index.ls'

  node:
    fs: "empty"
    tls: "empty"


  output:
    path: path.join __dirname, 'public'
    publicPath: '/'
    filename: 'bundle.js'
    pathinfo: yes

  resolve:
    extensions:
      * ''
      * '.ls'
      * '.js'

  module:
    loaders:
      * test: /\.ls$/ loader: \livescript
      * test: /\.styl$/ loader: \style!css!stylus
      * test: /\.css$/ loader: \style!css
      * test: /\.png|.svg$/ loader: \file
      * test: /\.json$/ loader: \json
