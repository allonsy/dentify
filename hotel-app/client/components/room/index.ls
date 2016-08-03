require './index.styl'
react = require 'react'
isvg = react.createFactory require 'react-inlinesvg'
{div} = react.DOM


class Room extends react.Component

  render: ->
    div className: "c-room #{@props.status}",
      div className: 'door-label',
        isvg src: require "./#{@props.status}-1.svg"
        div className: 'status-text', @props.status


module.exports = Room
