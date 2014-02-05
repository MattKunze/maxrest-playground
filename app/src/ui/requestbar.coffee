do (
  React = require 'react'
  DropdownButton = require './dropdownbutton'
) ->

  { div, span, form, input, a } = React.DOM

  QueryBar = React.createClass

    mixins: [ React.addons.LinkedStateMixin ]

    getInitialState: ->
      queryText: ''
      postData: ''
      method: 'GET'

    setMethod: (method) ->
      @setState { method }

    performRequest: (ev) ->
      ev.preventDefault()

      if @state.queryText
        @props.performRequest @state.method, @state.queryText, @state.postData

    render: ->

      buttonClass = switch @state.method
        when 'GET' then 'btn-info'
        when 'POST' then 'btn-warning'
        when 'PUT' then 'btn-primary'
        when 'DELETE' then 'btn-danger'

      div className: 'request-bar navbar navbar-default',
        span className: 'navbar-text', 'Request'

        form className: 'navbar-form',
          div className: 'form-group col-xs-5',
            input
              type: 'text'
              className: 'form-control'
              placeholder: 'Query Text'
              valueLink: @linkState 'queryText'

          div className: 'form-group col-xs-5',
            input
              type: 'text'
              className: 'form-control'
              placeholder: 'Post Data'
              valueLink: @linkState 'postData'

          DropdownButton
            buttonClass: buttonClass
            menuItems: [ 'GET', 'POST', 'PUT', 'DELETE' ]
            buttonClick: @performRequest
            menuClick: @setMethod
          ,
            @state.method

  module.exports = QueryBar

