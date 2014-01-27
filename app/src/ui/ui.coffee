do (
  React = require 'react/addons'
  Header = require './header'
  httpinvoke = require 'httpinvoke'
) ->

  {img, h1, a, p, pre} = React.DOM

  UI = React.createClass

    getInitialState: ->
      serverBase: 'http://10.255.255.20:9080/maxrest/rest/'
      userName: ''
      password: ''
      verifyState: 'unknown'

    verifyConnection: (serverBase, userName, password) ->
      auth = btoa "#{userName}:#{password}"
      (httpinvoke @state.serverBase, 'GET')
        .then (results) ->
          console.warn results
         , (error) ->
          console.error error

      false

    render: ->
      Header
        serverBase: @state.serverBase
        userName: @state.userName
        password: @state.password
        verifyState: 'unknown'
        verifyConnection: @verifyConnection

  module.exports = UI
