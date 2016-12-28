# app startup.
define ["backbone", "marionette", "msgbus", "apps/load" ], (Backbone, Marionette, msgBus ) ->
    appChannel= msgBus.appChannel

    app = new Marionette.Application
        region: "#main-region"

        onBeforeStart: (options={})->
            appChannel.trigger "start:header:app"
            appChannel.trigger "start:footer:app"
            appChannel.trigger "start:d3:app"
            appChannel.trigger "start:about:app"
            appChannel.trigger "start:games:app"
            appChannel.trigger "start:playa:app"

        onStart:->
            appstate = appChannel.request  "get:current:appstate"
            # trigger a specific event when the loginStatus ever changes (to be handled by our header list controller to show/hide login UI
            #    msgBus.events.trigger "login:status:change", status
            if Backbone.history
                Backbone.history.start()
                frag = Backbone.history.fragment
                match = /access_token/i.test frag # calling back into our app from twitch sign-in
                if match
                    # NEW, find the token as the string between '=','&'
                    # IE: http://twitchtvexpose.herokuapp.com/#access_token=a;ajf;aljf;adljkf;flajf&scope=xyz
                    appstate.set "accessToken",  frag.split(/[=&]/)[1]  #was frag.split("=")[1]  but the return now includes &scopes... after access_token
                    appstate.set "authState": true
                    Backbone.history.navigate "#games", trigger: true
                else
                    appstate.set "authState": false
                    Backbone.history.navigate "#about", trigger: true # if @getCurrentRoute() is null




    # default region to show views....
    appChannel.reply "default:region", ->
        app.getRegion()

   
    app