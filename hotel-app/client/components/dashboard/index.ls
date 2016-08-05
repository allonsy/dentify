require './index.styl'
react = require 'react'
io = require 'socket.io-client'
db = require '../../../../shareDB'
{div, li, nav, ul} = react.DOM
button = react.createFactory require 'react-bootstrap/lib/Button.js'
FloorPlan = react.createFactory require '../floor_plan'


class DashBoard extends react.Component

  xrot = 60
  zrot = -45
  xtrans = 0
  ytrans = -1000
  ztrans = -600
  floorHeight = 200

  focusFloor =
    transform: "rotateX(#{xrot}deg) translateZ(-20px) translateY(0px) rotateZ(0deg) translateX(200px)"
    transform-style: 'preserve-3d'

  hiddenUpperFloor =
    transform: "rotateX(#{xrot}deg) translateZ(#{ztrans+5000}px) translateY(#{ytrans}px) rotateZ(#{zrot}deg)"
    transform-style: 'preserve-3d'

  hiddenLowerFloor =
    transform: "rotateX(#{xrot}deg) translateZ(#{ztrans-5000}px) translateY(#{ytrans}px) rotateZ(#{zrot}deg)"
    transform-style: 'preserve-3d'

  floorStyles = [
    {
      transform: "rotateX(#{xrot}deg) translateZ(#{ztrans}px) translateY(#{ytrans}px) rotateZ(#{zrot}deg) translateX(#{xtrans}px)"
      transform-style: 'preserve-3d'
    },
    {
      transform: "rotateX(#{xrot}deg) translateZ(#{ztrans+floorHeight*1}px) translateY(#{ytrans}px) rotateZ(#{zrot}deg) translateX(#{xtrans}px)"
      transform-style: 'preserve-3d'
    },
    {
      transform: "rotateX(#{xrot}deg) translateZ(#{ztrans+floorHeight*2}px) translateY(#{ytrans}px) rotateZ(#{zrot}deg) translateX(#{xtrans}px)"
      transform-style: 'preserve-3d'
    }
  ]


  ->
    @state =
      floors: db.floors
      focus: -1
      selectedRooms: []
    @socket = io!
    @socket.on 'connection', -> console.log 'connected'


  componentDidMount: ~>
    @socket.on 'update', (data) ~>
      @setState floors: data.floors


  focusFloor: (f) ->
    @setState focus: f


  setStyle: (f) ->
    if @state.focus is -1
      floorStyles[f]
    else
      if f is @state.focus
        focusFloor
      else if f > @state.focus
        hiddenUpperFloor
      else
        hiddenLowerFloor


  reset: ~>
    @setState focus: -1


  selectRoom: (room) ~>
    selectedRooms = @state.selectedRooms
    selectedRooms.push room
    @setState selectedRooms: selectedRooms


  book: ~>
    console.log "booking: ", @state.selectedRooms


  checkin: ~>
    console.log "checking in: ", @state.selectedRooms


  checkout: ~>
    console.log "checking out: ", @state.selectedRooms



  render: ->
    div className: 'c-dashboard',
      nav {},
        ul {},
          li {},
            button {bsStyle: 'primary', onClick: @reset}, 'Back'
          if @state.focus > -1
            div {},
              li {},
                button className: 'book', onClick: @book, 'Book'
              li {},
                button className: 'checkin', onClick: @checkin, 'Check In'
              li {},
                button className: 'checkout', onClick: @checkout, 'Check Out'

      div className: 'floors',
        # loop doesn't work for some reason... always focuses on floor 2
        # for floor, i in @state.floors
        FloorPlan {
          # key: i
          style: @setStyle 0
          onClick: ~> @focusFloor 0
          showMarkers: @state.focus is 0
          rooms: @state.floors[0].rooms
          onSelectRoom: @selectRoom
          floorNo: 0
        }
        FloorPlan {
          # key: i
          style: @setStyle 1
          onClick: ~> @focusFloor 1
          showMarkers: @state.focus is 1
          rooms: @state.floors[1].rooms
          onSelectRoom: @selectRoom
          floorNo: 1
        }
        FloorPlan {
          # key: i
          style: @setStyle 2
          onClick: ~> @focusFloor 2
          showMarkers: @state.focus is 2
          rooms: @state.floors[2].rooms
          onSelectRoom: @selectRoom
          floorNo: 2
        }


module.exports = DashBoard
