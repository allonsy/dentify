require './index.styl'
react = require 'react'
isvg = react.createFactory require 'react-inlinesvg'
{div} = react.DOM


class Room extends react.Component

  ->
    @state =
      showMarker: no
      uprightMarker: yes


  componentDidMount: ~>
    @setState showMarker: @props.showMarker


  # toggle: (e) ~>
    # @setState uprightMarker: !@state.uprightMarker


  # uprightMarkerStyle =
  #   transform: 'rotateX(-90deg) rotateY(-45deg)'
  #   transition: 'transform 3s ease'
  #   left: '50%'
  #   top: '50%'
  #   position: 'absolute'

  # downMarkerStyle =
  #   transition: 'transform 3s ease'
  #   left: '50%'
  #   top: '50%'
  #   position: 'absolute'

  render: ->
    div className: "c-room #{@props.status}", onClick: @toggle,
      if @state.showMarker
        div className: 'door-label', #style: if @state.uprightMarker then uprightMarkerStyle else downMarkerStyle,
          div className: 'marker',
            isvg src: require "./#{@props.status}-1.svg"
          # div className: 'status-text', @props.status


module.exports = Room
