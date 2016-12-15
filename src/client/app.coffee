# app startup.
define ["backbone", "marionette", "msgbus", "entities/appstate", "apps/load" ], (Backbone, Marionette, msgBus, AppState ) ->
    appChannel = msgBus.appChannel

    app = new Backbone.Marionette.Application()

    app.rootRoute = "about"
    app.authRoute = "games"

    app.addRegions
        headerRegion : "#header-region"
        mainRegion : "  #main-region"
        footerRegion : "#footer-region"


    appChannel.reply "default:region",->
        app.mainRegion

    appChannel.reply "header:region", ->
        app.headerRegion

    appChannel.reply "footer:region", ->
        app.footerRegion

    appChannel.reply "main:region", ->
        app.mainRegion

    appChannel.reply "register:instance", (instance, id) ->
        app.register instance, id

    appChannel.reply "unregister:instance", (instance, id) ->
        app.unregister instance, id

    app.on "before:start", ->
        console.log "before:start"
    

    app.on "start", (options={})->
        console.log "app:start"

        # trigger a specific event when the loginStatus ever changes (to be handled by our header list controller to show/hide login UI
        # appstate.on "change:loginStatus" (model, status)->
        #    msgBus.events.trigger "login:status:change", status

        if Backbone.history
            Backbone.history.start()
            frag = Backbone.history.fragment
            match = /access_token/i.test frag # calling back into our app from twitch sign-in
            appChannel.trigger "start:header:app"
            appChannel.trigger "start:about:app"
            appChannel.trigger "start:footer:app"
            appChannel.trigger "start:d3:app"
            appChannel.trigger "start:games:app"
            appChannel.trigger "start:playa:app"
            
            if match
                # NEW, find the token as the string between '=','&' IE: http://twitchtvexpose.herokuapp.com/#access_token=a;ajf;aljf;adljkf;flajf&scope=..... 
                AppState.set "accessToken",  frag.split(/[=&]/)[1]  #was frag.split("=")[1]  but the return now includes &scopes... after access_token
                AppState.set "loginStatus", true
                
                #console.log "TwitchTV accessToken: #{appstate.get("accessToken")}"
                @navigate @authRoute, trigger: true
            else
                AppState.set "loginStatus", false
                @navigate @rootRoute, trigger: true if @getCurrentRoute() is null
        else
            console.log "No BackBone.history"


    app