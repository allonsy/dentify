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
      console.log 'beUpdate: ', data
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
    if room.selected  
      selectedRooms.push room
    else
      for selectedRoom, i in selectedRooms
        if selectedRoom?.roomNo is room.roomNo and selectedRoom?.floorNo is room.floorNo
          selectedRooms.splice i, 1
    @setState selectedRooms: selectedRooms


  update: (status) ~>
    selectedRooms = @state.selectedRooms
    floors = @state.floors

    # wow n^3 so efficient
    for floor in floors
      for selectedRoom in selectedRooms
        if floor.floorNo is selectedRoom.floorNo
          for room in floor.rooms
            if room.roomNo is selectedRoom.roomNo
              room.status = status
    db.floors = floors
    @socket.emit 'feUpdate', db


  render: ->
    div className: 'c-dashboard',
      nav {},
        ul {},
          li {},
            button {bsStyle: 'primary', onClick: @reset}, 'Back'
          if @state.focus > -1
            div {},
              li {},
                button {className: 'book', onClick: ~> @update 'booked'}, 'Book'
              li {},
                button {className: 'checkin', onClick: ~> @update 'checked-in'}, 'Check In'
              li {},
                button {className: 'checkout', onClick: ~> @update 'available'}, 'Check Out'
              li {}, "Rooms selected: #{@state.selectedRooms.length}"

      div className: 'floors',
        # loop doesn't work for some reason... always focuses on 3rd floor
        # for floor, i in @state.floors
        #   FloorPlan {
        #     key: i
        #     style: @setStyle i
        #     onClick: ~> @focusFloor i
        #     showMarkers: @state.focus is i
        #     rooms: @state.floors[i].rooms
        #     onSelectRoom: @selectRoom
        #     floorNo: i+1
        #   }
        FloorPlan {
          style: @setStyle 0
          onClick: ~> @focusFloor 0
          showMarkers: @state.focus is 0
          rooms: @state.floors[0].rooms
          onSelectRoom: @selectRoom
          floorNo: 1
        }

        FloorPlan {
          style: @setStyle 1
          onClick: ~> @focusFloor 1
          showMarkers: @state.focus is 1
          rooms: @state.floors[1].rooms
          onSelectRoom: @selectRoom
          floorNo: 2
        }

        FloorPlan {
          style: @setStyle 2
          onClick: ~> @focusFloor 2
          showMarkers: @state.focus is 2
          rooms: @state.floors[2].rooms
          onSelectRoom: @selectRoom
          floorNo: 3
        }


module.exports = DashBoard
