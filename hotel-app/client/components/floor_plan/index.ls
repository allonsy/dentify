require './index.styl'
react = require 'react'
{div} = react.DOM
Room = react.createFactory require '../room'


class FloorPlan extends react.Component

  render: ->
    div className: 'c-floor-plan',
      Room status: 'booked'
      Room status: 'booked'
      Room status: 'available'
      Room status: 'available'
      Room status: 'booked'
      Room status: 'checked-in'


module.exports = FloorPlan
