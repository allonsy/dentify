require './index.styl'
react = require 'react'
{div} = react.DOM
FloorPlan = react.createFactory require '../floor_plan'


class DashBoard extends react.Component

  firstFloor =
    transform: 'rotateX(45deg) rotateZ(-45deg) translateX(400px) translateY(-400px) translateZ(-300px)'
    transform-style: 'preserve-3d'
    -webkit-transform-style: 'preserve-3d'
    z-index: '3'

  secondFloor =
    transform: 'rotateX(45deg) rotateZ(-45deg) translateX(400px) translateY(-400px) translateZ(-300px)'
    transform-style: 'preserve-3d'
    -webkit-transform-style: 'preserve-3d'
    z-index: '2'

  thirdFloor =
    transform: 'rotateX(45deg) rotateZ(-45deg) translateX(400px) translateY(-400px) translateZ(-300px)'
    transform-style: 'preserve-3d'
    -webkit-transform-style: 'preserve-3d'
    z-index: '1'

  render: ->
    div className: 'c-dashboard',
      FloorPlan {showMarkers: yes, style: firstFloor}
      FloorPlan {showMarkers: yes, style: secondFloor}
      FloorPlan {showMarkers: yes, style: thirdFloor}


module.exports = DashBoard
