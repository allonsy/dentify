path = require 'path'
webpack = require 'webpack'


module.exports =

  entry: path.join __dirname, 'client/index.coffee'

  output:
    path: path.join __dirname, 'public'
    publicPath: '/'
    filename: 'bundle.js'
    pathinfo: yes

  resolve:
    extensions: [''
                 '.coffee'
                 '.js'
                ]

  module:
    loaders: [
      {test: /\.coffee$/,     loader: 'coffee'}
    ]
