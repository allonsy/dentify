react = require 'react'
{div} = react.DOM
browserHistory = require 'react-router/lib/browserHistory'
Route = react.createFactory require 'react-router/lib/Route'
Router = react.createFactory require 'react-router/lib/Router'
HomePage = require '../home_page'


class Root extends react.Component

  render: ->
    Router history: browserHistory,
      Route path: '/', component: HomePage

module.exports = Root
