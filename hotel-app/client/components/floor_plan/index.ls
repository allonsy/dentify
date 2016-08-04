require './index.styl'
react = require 'react'
{div} = react.DOM
Room = react.createFactory require '../room'


class FloorPlan extends react.Component


  render: ->
    div className: "c-floor-plan #{if @props.showMarkers then 'focused' else ''}", style: @props.style, onClick: @props.onClick,
      div className: 'top',
        for room, i in @props.rooms[0 til @props.rooms.length/2]
          Room status: room.status, key: i, showMarker: @props.showMarkers, focused: @props.showMarkers
      div className: 'bottom',
        for room, i in @props.rooms[@props.rooms.length/2 til @props.rooms.length]
          Room status: room.status, key: i, showMarker: @props.showMarkers, focused: @props.showMarkers


module.exports = FloorPlan
