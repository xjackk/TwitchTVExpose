# header app/module.
define ["msgbus","apps/header/list/controller"], (msgBus, Controller) ->
    appChannel = msgBus.appChannel
    API =
        list: ->
            new Controller 
                #region: msgBus.reqres.request "header:region"
    #start up
    appChannel.on "start:header:app", ->
        API.list()