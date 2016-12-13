# header app/module.
define ["msgbus","apps/header/list/controller"], (msgBus, Controller) ->
    channel = msgBus.appChannel

    API =
        list: ->
            new Controller 
                region: channel.request "header:region"
    #start up
    channel.on "start:header:app", ->
        API.list()