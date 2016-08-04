require './index.styl'
react = require 'react'
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
    @state = focus: -1


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


  render: ->
    div className: 'c-dashboard',
      nav {},
        ul {},
          li {},
            button {bsStyle: 'primary', onClick: @reset}, 'Back'
      div className: 'floors',
        FloorPlan {
          style: @setStyle 0
          onClick: ~> @focusFloor 0
          showMarkers: @state.focus is 0
        }
        FloorPlan {
          style: @setStyle 1
          onClick: ~> @focusFloor 1
          showMarkers: @state.focus is 1
        }
        FloorPlan {
          style: @setStyle 2
          onClick: ~> @focusFloor 2
          showMarkers: @state.focus is 2
        }


module.exports = DashBoard
