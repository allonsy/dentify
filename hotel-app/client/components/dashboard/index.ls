require './index.styl'
react = require 'react'
{div} = react.DOM
FloorPlan = react.createFactory require '../floor_plan'


class DashBoard extends react.Component

  render: ->
    div className: 'c-dashboard',
      FloorPlan {}


module.exports = DashBoard
