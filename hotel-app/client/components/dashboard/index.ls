require './index.styl'
react = require 'react'
{div} = react.DOM
Room = react.createFactory require '../room'


class DashBoard extends react.Component

  render: ->
    div className: 'c-dashboard'#,
      # Room {}, ''


module.exports = DashBoard
