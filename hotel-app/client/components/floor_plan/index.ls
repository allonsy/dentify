require './index.styl'
react = require 'react'
{div} = react.DOM
db = require '../../../../shareDB'
Room = react.createFactory require '../room'
io = require 'socket.io-client'

class FloorPlan extends react.Component


  ->
    @state = rooms: db.rooms
    @socket = io!
    @socket.on 'connection', -> console.log 'connected'


  componentDidMount: ~>
    @socket.on 'update', (data) ~>
      console.log data
      @setState room: db.rooms


  render: ->
    div className: 'c-floor-plan',
      div className: 'top',
        for room, i in @state.rooms[0 til @state.rooms.length/2]
          Room status: room.status, key: i, width: room.w, height: room.h, showMarker: @props.showMarkers
      div className: 'bottom',
        for room, i in @state.rooms[@state.rooms.length/2 til @state.rooms.length]
          Room status: room.status, key: i, width: room.w, height: room.h, showMarker: @props.showMarkers


module.exports = FloorPlan
