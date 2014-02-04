do (
  React = require 'react/addons'
  Header = require './header'
  httpinvoke = require 'httpinvoke'
) ->

  {div, span, img, h1, a, p, pre} = React.DOM

  UI = React.createClass

    getInitialState: ->
      serverBase: 'http://localhost:9081/proxy/maxrest'
      userName: ''
      password: ''
      verifyState: 'unknown'

    verifyConnection: (serverBase, userName, password) ->
      @setState verifyState: 'verifying'
      auth = btoa "#{userName}:#{password}"
      url = "#{serverBase}:MaxAuth=#{auth}/mbo/PERSON?personid=~eq~0"
      (httpinvoke url, 'GET')
        .then (results) =>
          console.warn results
          if results.statusCode is 200
            @setState verifyState: 'success'
          else
            @setState verifyState: 'error'
         , (error) =>
          console.error error
          @setState verifyState: 'error'

      false

    render: ->
      Header
        serverBase: @state.serverBase
        userName: @state.userName
        password: @state.password
        verifyState: @state.verifyState
        verifyConnection: @verifyConnection

  module.exports = UI
