# app startup.
define ["backbone", "marionette", "msgbus", "apps/load" ], (Backbone, Marionette, msgBus ) ->
    app = new Marionette.Application()

    app.rootRoute = "about"
    app.authRoute = "top"

    app.addRegions
        headerRegion : "#header-region"
        mainRegion : "#main-region"
        footerRegion : "#footer-region"
        jackRegion : "#jack-region"

    app.on "initialize:before", (options={}) ->
        console.log "init:before", options

    msgBus.reqres.setHandler "default:region",->
        app.mainRegion

    msgBus.reqres.setHandler "jack:region",->
        app.jackRegion

    msgBus.reqres.setHandler "header:region", ->
        app.headerRegion

    msgBus.reqres.setHandler "footer:region", ->
        app.footerRegion

    msgBus.reqres.setHandler "main:region", ->
        app.mainRegion

    msgBus.commands.setHandler "register:instance", (instance, id) ->
        app.register instance, id

    msgBus.commands.setHandler "unregister:instance", (instance, id) ->
        app.unregister instance, id



    app.on "initialize:after", (options={})->
        console.log "init:after>>"
        appstate = msgBus.reqres.request "get:current:appstate"
        # trigger a specific event when the loginStatus ever changes (to be handled by our header list controller to show/hide login UI
        # appstate.on "change:loginStatus" (model, status)->
        #    msgBus.events.trigger "login:status:change", status

        if Backbone.history
            Backbone.history.start()
            frag = Backbone.history.fragment
            match = /access_token/i.test frag  # hey jack I like this better than .indexOf ...
            if match
                appstate.set "accessToken",  frag.split("=")[1]
                appstate.set "loginStatus", true
                console.log "top route", @authRoute
                @navigate(@authRoute, trigger: true)             #Backbone.history.navigate @rootRoute, trigger:true                
            else
                console.log "else statement"
                @navigate(@rootRoute, trigger: true) if @getCurrentRoute() is null             #Backbone.history.navigate @rootRoute, trigger:true

    app.addInitializer (options) ->
        console.log "addinitializers"
        msgBus.commands.execute "start:header:app"
        msgBus.commands.execute "start:footer:app"
        msgBus.commands.execute "start:d3:app"
        msgBus.commands.execute "start:about:app"
        msgBus.commands.execute "start:oauth:app"
        msgBus.commands.execute "start:top:app"





    app