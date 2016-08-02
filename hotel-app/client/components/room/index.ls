require './index.styl'
react = require 'react'
{div} = react.DOM


class Room extends react.Component

  render: ->
    div className: "c-room #{@props.status}", 
      div className: "status #{@props.status}"
      div className: 'status-text', @props.status


module.exports = Room
