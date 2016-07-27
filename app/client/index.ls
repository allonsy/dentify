# require! {
#   './application.styl'
# }
require './base_css'
reactDom = require 'react-dom'
react = require 'react'
Root = require './components/root'


reactDom.render react.createElement(Root), document.getElementById('foo')
