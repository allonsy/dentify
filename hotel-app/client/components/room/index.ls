require './index.styl'
react = require 'react'
isvg = react.createFactory require 'react-inlinesvg'
{div} = react.DOM


class Room extends react.Component


  render: ->
    div className: "c-room #{@props.status}", onClick: @toggle, style: pointer-events: @props.pointerEvents,
      if @props.showMarker
        div className: 'door-label',
          div className: 'marker',
            isvg src: (require "./#{@props.status}-1.svg"), key: @props.status


module.exports = Room
