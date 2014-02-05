do (
  React = require 'react'
) ->

  { div, h3 } = React.DOM

  RequestError = React.createClass

    render: ->
      div className: 'panel panel-danger',
        div className: 'panel-heading',
          div className: 'panel-title',
            "Something unexpected happend: #{@props.errorCode or 'unknown'}"
        div className: 'panel-body',
          @props.error

  module.exports = RequestError

