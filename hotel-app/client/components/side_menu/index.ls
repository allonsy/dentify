require './index.styl'
react = require 'react'
{div} = react.DOM


class SideMenu extends react.Component

  render: ->
    div className: 'c-side-menu', 'SideMenu'


module.exports = SideMenu
