require './index.styl'
react = require 'react'
isvg = react.createFactory require 'react-inlinesvg'
{div} = react.DOM


class Room extends react.Component

  ->
    @state = selected: no


  onSelect: ~>
    @setState selected: yes
    @props.onSelect {
      roomNo: @props.roomNo
      user: @props.user
      status: @props.status
      floorNo: @props.floorNo
    }


  render: ->
    div className: "c-room #{@props.status} #{if @props.focused then 'focused' else ''} #{if @props.focused and @state.selected then 'selected' else ''}", onClick: @onSelect, style: pointer-events: @props.pointerEvents,
      if @props.showMarker
        div className: 'door-label',
          div className: 'marker',
            isvg src: (require "./#{@props.status}-1.svg"), key: @props.status


module.exports = Room
