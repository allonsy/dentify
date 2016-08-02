require './index.styl'
react = require 'react'
{div} = react.DOM
db = require '../../../../shareDB'
Room = react.createFactory require '../room'


class FloorPlan extends react.Component

  render: ->
    div className: 'c-floor-plan',
      for room, i in db.rooms
        key: i
        Room status: room.status


module.exports = FloorPlan
