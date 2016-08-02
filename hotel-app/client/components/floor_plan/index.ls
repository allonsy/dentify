require './index.styl'
react = require 'react'
{div} = react.DOM
db = require '../../../../shareDB'
Room = react.createFactory require '../room'


class FloorPlan extends react.Component

  render: ->
    div className: 'c-floor-plan',
      for room, i in db.rooms
        Room status: room.status, key: i, width: room.w, height: room.h


module.exports = FloorPlan
