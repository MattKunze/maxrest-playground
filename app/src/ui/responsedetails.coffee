do (
  React = require 'react'
) ->

  { pre } = React.DOM

  ResponseDetails = React.createClass

    render: ->

      # try to format JSON
      results = @props.results
      try
        json = JSON.parse results
        results = JSON.stringify json, null, '  '
      catch error
        console.error error

      pre {}, results

  module.exports = ResponseDetails


