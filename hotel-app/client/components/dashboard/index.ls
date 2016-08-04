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
  ztrans = -700
  ytrans = -1000
  floorHeight = 200


  # rotateX(60deg) translateZ(-20px) translateY(-000px) rotateZ(-0deg) translateX(300px)
  focusFloor =
    transform: "rotateX(#{xrot}deg) translateZ(-20px) translateY(0px) rotateZ(0deg) translateX(300px)"
    transform-style: 'preserve-3d'

  hiddenUpperFloor =
    transform: "rotateX(#{xrot}deg) translateZ(#{ztrans+5000}px) translateY(#{ytrans}px) rotateZ(#{zrot}deg)"
    transform-style: 'preserve-3d'

  hiddenLowerFloor =
    transform: "rotateX(#{xrot}deg) translateZ(#{ztrans-5000}px) translateY(#{ytrans}px) rotateZ(#{zrot}deg)"
    transform-style: 'preserve-3d'

  floorStyles = [
    {
      transform: "rotateX(#{xrot}deg) translateZ(#{ztrans}px) translateY(#{ytrans}px) rotateZ(#{zrot}deg)"
      transform-style: 'preserve-3d'
    },
    {
      transform: "rotateX(#{xrot}deg) translateZ(#{ztrans+floorHeight*1}px) translateY(#{ytrans}px) rotateZ(#{zrot}deg)"
      transform-style: 'preserve-3d'
    },
    {
      transform: "rotateX(#{xrot}deg) translateZ(#{ztrans+floorHeight*2}px) translateY(#{ytrans}px) rotateZ(#{zrot}deg)"
      transform-style: 'preserve-3d'
    }
  ]

  ->
    @state =
      floors: db.floors
      focus: -1
    @socket = io!
    @socket.on 'connection', -> console.log 'connected'


  componentDidMount: ~>
    @socket.on 'update', (data) ~>
      @setState floors: data.floors


  focusFloor: (f) ->
    console.log "focusing on #{f}"
    @setState focus: f


  setStyle: (f) ->
    console.log "@state.focus: #{@state.focus}"
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


  render: ->
    div className: 'c-dashboard',
      nav {},
        ul {},
          li {},
            button {bsStyle: 'primary', onClick: @reset}, 'Back'
      div className: 'floors',
        # loop doesn't work for some reason... always focusses on floor 2
        # for floor, i in @state.floors
        FloorPlan {
          # key: i
          style: @setStyle 0
          onClick: ~> @focusFloor 0
          showMarkers: @state.focus is 0
          rooms: @state.floors[0].rooms
        }
        FloorPlan {
          # key: i
          style: @setStyle 1
          onClick: ~> @focusFloor 1
          showMarkers: @state.focus is 1
          rooms: @state.floors[1].rooms
        }
        FloorPlan {
          # key: i
          style: @setStyle 2
          onClick: ~> @focusFloor 2
          showMarkers: @state.focus is 2
          rooms: @state.floors[2].rooms
        }


module.exports = DashBoard
