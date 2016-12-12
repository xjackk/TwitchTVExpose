# app startup.
define ["backbone", "marionette", "msgbus","entities/appstate", "apps/load" ], (Backbone, Marionette, msgBus, AppState ) ->
    app = new Backbone.Marionette.Application()

    app.rootRoute = "about"
    app.authRoute = "games"

    app.addRegions
        headerRegion : "#header-region"
        mainRegion : "  #main-region"
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


    app.on "start", (options={})->
        
        # trigger a specific event when the loginStatus ever changes (to be handled by our header list controller to show/hide login UI
        # appstate.on "change:loginStatus" (model, status)->
        #    msgBus.events.trigger "login:status:change", status

        if Backbone.history
            Backbone.history.start()
            frag = Backbone.history.fragment
            match = /access_token/i.test frag # calling back into our app from twitch sign-in
            if match
                # NEW, find the token as the string between '=','&' IE: http://twitchtvexpose.herokuapp.com/#access_token=a;ajf;aljf;adljkf;flajf&scope=..... 
                AppState.set "accessToken",  frag.split(/[=&]/)[1]  #was frag.split("=")[1]  but the return now includes &scopes... after access_token
                AppState.set "loginStatus", true
                #console.log "TwitchTV accessToken: #{appstate.get("accessToken")}"
                @navigate @authRoute, trigger: true
            else
                AppState.set "loginStatus", false
                @navigate @rootRoute, trigger: true if @getCurrentRoute() is null

    app.addInitializer (options) ->
        #console.log "addinitializers"
        msgBus.commands.execute "start:header:app"
        msgBus.commands.execute "start:footer:app"
        msgBus.commands.execute "start:d3:app"
        msgBus.commands.execute "start:about:app"
        msgBus.commands.execute "start:games:app"
        msgBus.commands.execute "start:playa:app"

    app