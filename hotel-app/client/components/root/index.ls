react = require 'react'
Route = react.createFactory require 'react-router/lib/Route'
Router = react.createFactory require 'react-router/lib/Router'
browserHistory = require 'react-router/lib/browserHistory'
DashBoard = require '../dashboard'


class Root extends react.Component

  render: ->
    Router history: browserHistory,
      Route path: '/', component: DashBoard


module.exports = Root
