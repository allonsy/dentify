require './index.styl'
react = require 'react'
{div} = react.DOM


class Room extends react.Component

  render: ->
    div className: 'c-room'
