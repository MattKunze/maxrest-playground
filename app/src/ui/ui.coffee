do (
  httpinvoke = require 'httpinvoke'
  React = require 'react/addons'
  Header = require './header'
  RequestBar = require './requestbar'
  ResponseDetails = require './responsedetails'
  ResponseError = require './responseerror'
) ->

  {div, span, img, h1, a, p, pre} = React.DOM

  UI = React.createClass

    getInitialState: ->
      serverBase: 'http://localhost:9180/proxy/maxrest'
      userName: ''
      password: ''
      verifyState: 'unknown'
      results: null
      error: null
      errorCode: null

    verifyConnection: (serverBase, userName, password) ->
      @setState verifyState: 'verifying'
      @_clearResults()
      auth = btoa "#{userName}:#{password}"
      url = "#{serverBase}:MaxAuth=#{auth}/mbo/MAXUSER?personid=~eq~#{userName}&_format=json&_compact=1"
      (httpinvoke url, 'GET')
        .then (results) =>
          if results.statusCode is 200
            @setState
              results: results.body
              verifyState: 'success'
              serverBase: serverBase
              userName: userName
              password: password
          else
            @setState
              verifyState: 'error'
              error: results.body
              errorCode: results.statusCode
         , (error) =>
          @setState
            verifyState: 'error'
            error: error

      false

    performRequest: (method, queryText, postData) ->
      @_clearResults()

      auth = btoa "#{@state.userName}:#{@state.password}"
      queryText = '/' + queryText unless queryText[0] is '/'
      url = "#{@state.serverBase}:MaxAuth=#{auth}#{queryText}"
      options =
        input: postData
        inputType: if postData then 'text' else 'auto'
      (httpinvoke url, method, options)
        .then (results) =>
          if results.statusCode is 200
            @setState results: results.body
          else
            @setState error: results.body, errorCode: results.statusCode
        , (error) ->
          @setState { error }
          console.error error

    render: ->
      div className: 'app',
        Header
          serverBase: @state.serverBase
          userName: @state.userName
          password: @state.password
          verifyState: @state.verifyState
          verifyConnection: @verifyConnection

        if @state.verifyState is 'success'
          RequestBar
            performRequest: @performRequest

        div className: 'container',
          if @state.results
            ResponseDetails
              results: @state.results
          else if @state.error
            ResponseError
              error: @state.error
              errorCode: @state.errorCode
          else
            div className: 'panel panel-default',
              div className: 'panel-body',
                'Waiting for request'

    _clearResults: ->
      @setState
        results: null
        error: null
        errorCode: null

  module.exports = UI
