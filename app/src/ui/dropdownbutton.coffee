do (
  _ = require 'lodash'
  React = require 'react'
) ->

  { div, span, button, ul, li, a } = React.DOM


  DropdownButton = React.createClass
    displayName: 'DropdownButton'

    getDefaultProps: ->
      buttonClass: 'btn-default'
      split: true
      menuItems: []
      buttonClick: null
      menuClick: null

    getInitialState: ->
      open: false

    toggle: (ev) ->
      @setState open: not @state.open
      ev.preventDefault()

    clickMenuItem: (item) ->
      @props.menuClick item if @props.menuClick
      @setState open: false

    render: ->
      div { className: 'btn-group' + if @state.open then ' open' else '' },
        if @props.split
          button
            className: "btn #{@props.buttonClass}"
            onClick: @props.buttonClick
          ,
            @props.children

        button
          className: "btn dropdown-toggle #{@props.buttonClass}"
          onClick: @toggle
        ,
          @props.children unless @props.split
          span className: 'caret'
        ul className: 'dropdown-menu',
          for item in @props.menuItems
            li key: item,
              a { onClick: _.bind @clickMenuItem, @, item}, item

  module.exports = DropdownButton
