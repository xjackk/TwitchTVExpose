# app startup.
define ["backbone", "marionette", "msgbus", "apps/load" ], (Backbone, Marionette, msgBus ) ->
    appChannel= msgBus.appChannel

    app = new Marionette.Application
        region: "#main-region"

    app.rootRoute = "about"
    app.authRoute = "games"


    # default region to show views....
    appChannel.reply "default:region", ->
        app.getRegion()


    app.on "before:start" , (options={})->
        appChannel.trigger "start:about:app"
        appChannel.trigger "start:header:app"
        appChannel.trigger "start:footer:app"
        appChannel.trigger "start:d3:app"
        #msgBus.commands.execute "start:about:app"
        #msgBus.commands.execute "start:games:app"
        #sgBus.commands.execute "start:playa:app"
    

    app.on "start", (options={})->
        appstate = appChannel.request  "get:current:appstate"
        # trigger a specific event when the loginStatus ever changes (to be handled by our header list controller to show/hide login UI
        # appstate.on "change:loginStatus" (model, status)->
        #    msgBus.events.trigger "login:status:change", status

        if Backbone.history
            Backbone.history.start()
            frag = Backbone.history.fragment
            match = /access_token/i.test frag # calling back into our app from twitch sign-in
            if match
                # NEW, find the token as the string between '=','&' IE: http://twitchtvexpose.herokuapp.com/#access_token=a;ajf;aljf;adljkf;flajf&scope=..... 
                appstate.set "accessToken",  frag.split(/[=&]/)[1]  #was frag.split("=")[1]  but the return now includes &scopes... after access_token
                appstate.set "loginStatus", true
                #console.log "TwitchTV accessToken: #{appstate.get("accessToken")}"
                #@navigate @authRoute, trigger: true
                @navigate @rootRoute, trigger: true if @getCurrentRoute() is null
            else
                #appstate.set "loginStatus", false
                @navigate @rootRoute, trigger: true if @getCurrentRoute() is null

   
    app