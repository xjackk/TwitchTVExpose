# app startup.
define ["backbone", "marionette", "msgbus", "apps/load" ], (Backbone, Marionette, msgBus ) ->
    app = new Marionette.Application()

    app.rootRoute = "about"
    app.authRoute = "games"

    app.addRegions
        headerRegion : "#header-region"
        mainRegion : "#main-region"
        footerRegion : "#footer-region"

    app.on "initialize:before", (options={}) ->
        #console.log "init:before", options

    msgBus.reqres.setHandler "default:region",->
        app.mainRegion

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
        #console.log "init:after"
        appstate = msgBus.reqres.request "get:current:appstate"
        # trigger a specific event when the loginStatus ever changes (to be handled by our header list controller to show/hide login UI
        # appstate.on "change:loginStatus" (model, status)->
        #    msgBus.events.trigger "login:status:change", status

        if Backbone.history
            Backbone.history.start()
            frag = Backbone.history.fragment
            match = /access_token/i.test frag  # hey jack I like this better than .indexOf ...
            #console.log match, "<< match access_token"
            if match
                appstate.set "accessToken",  frag.split("=")[1]
                appstate.set "loginStatus", true
                #console.log "top route", @authRoute
                @navigate(@authRoute, trigger: true)             #Backbone.history.navigate @rootRoute, trigger:true
            else
                appstate.set "loginStatus", false
                #console.log appstate.get("loginStatus"), "value of login status"
                @navigate(@rootRoute, trigger: true) if @getCurrentRoute() is null             #Backbone.history.navigate @rootRoute, trigger:true

    app.addInitializer (options) ->
        #console.log "addinitializers"
        msgBus.commands.execute "start:header:app"
        msgBus.commands.execute "start:footer:app"
        msgBus.commands.execute "start:d3:app"
        msgBus.commands.execute "start:about:app"
        msgBus.commands.execute "start:games:app"
        msgBus.commands.execute "start:playa:app"

    app