# header app/module.
define ["msgbus","apps/header/list/controller", "class/app","apps/header/list/views"], (msgBus, Controller, App, Views) ->
    app = new App "header"

    channel = msgBus.appChannel

    API =
        list: ->
            new Controller 
                region: channel.request "header:region"
                
    #start up
    channel.on "start:header:app", ->
        API.list()
    
    app
#