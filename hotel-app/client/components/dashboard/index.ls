react = require 'react'
{div} = react.DOM
require './index.styl'


class DashBoard extends react.Component

  render: ->
    div {}, 'DashBoard'


module.exports = DashBoard
