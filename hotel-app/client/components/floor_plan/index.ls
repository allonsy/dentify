require './index.styl'
react = require 'react'
{div} = react.DOM
Room = react.createFactory require '../room'


class FloorPlan extends react.Component


  render: ->
    div className: "c-floor-plan #{if @props.showMarkers then 'focused' else ''}", style: @props.style, onClick: @props.onClick,
      div className: 'top',
        for room, i in @props.rooms[0 til @props.rooms.length/2]
          Room {
            key: i
            status: room.status
            showMarker: @props.showMarkers
            focused: @props.showMarkers
            roomNo: room.roomNo
            user: room.user
            onSelect: @props.onSelectRoom
            floorNo: @props.floorNo
          }
      div className: 'floor-no', "Floor #{@props.floorNo}"
      div className: 'bottom',
        for room, i in @props.rooms[@props.rooms.length/2 til @props.rooms.length]
          Room {
            key: i
            status: room.status
            showMarker: @props.showMarkers
            focused: @props.showMarkers
            roomNo: room.roomNo
            user: room.user
            onSelect: @props.onSelectRoom
            floorNo: @props.floorNo
          }


module.exports = FloorPlan
