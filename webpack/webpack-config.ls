require! {
  'path'
}


module.exports =

  entry:
    main: path.resolve 'app/client/index.ls'


  output:
    path: path.resolve __dirname, '../public/assets'
    publicPath: '/'
    filename: 'bundle.js'

    # Output file paths to comments (These get compiled away in production)
    pathinfo: yes


  resolve:
    extensions:
      * ''
      * '.js'
      * '.ls'
      * '.styl'


  module:
    loaders:
      * test: /\.ls$/ loader: \livescript
      * test: /\.styl/ loader: \style!css!stylus
