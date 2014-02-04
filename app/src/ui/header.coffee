do (
  React = require 'react'
) ->

  { div, span, form, input, a } = React.DOM

  Header = React.createClass

    mixins: [ React.addons.LinkedStateMixin ]

    getInitialState: ->
      serverBase: @props.serverBase
      userName: @props.userName
      password: @props.password

    verifyConnection: ->
      if @state.serverBase and @state.userName and @state.password
        @props.verifyConnection @state.serverBase, @state.userName,
          @state.password

    render: ->
      verifyClass = switch @props.verifyState
        when 'verifying' then 'btn-info disabled'
        when 'success' then 'btn-success'
        when 'error' then 'btn-danger'
        else 'btn-default'

      div className: 'navbar navbar-inverse',
        span className: 'navbar-brand', 'RESTful Maximo'

        div className: 'collapse navbar-collapse',
          form className: 'navbar-form',
            div className: 'form-group col-xs-5',
              input
                type: 'text'
                className: 'form-control'
                placeholder: 'Service Address Base'
                valueLink: @linkState 'serverBase'
            div className: 'form-group col-xs-2',
              input
                type: 'text'
                className: 'form-control'
                placeholder: 'User Name'
                valueLink: @linkState 'userName'
            div className: 'form-group col-xs-2',
              input
                type: 'password'
                className: 'form-control'
                placeholder: 'Password'
                valueLink: @linkState 'password'
            div className: 'form-group col-xs-1',
              a
                className: "btn btn-block #{verifyClass}"
                onClick: @verifyConnection
              , 'Verify'

  module.exports = Header

