react = require 'react'
reactDom = require 'react-dom'
{div} = react.DOM

Root = (props) ->
  div {}, 'HomePage'


reactDom.render(
    react.createElement Root
    document.querySelector 'main'
  )
