# header app/module.
define ["msgbus","apps/header/list/controller"], (msgBus, Controller) ->
    channel = msgBus.appChannel

    temp = channel.request "header:region"
    console.log "header region", temp

    API =
        list: ->
            new Controller 
                region: channel.request "header:region"
                
    #start up
    channel.on "start:header:app", ->
        API.list()
        