define ["msgbus", "marionette", "apps/about/show/controller","class/app"], (msgBus, Marionette, Controller, App) ->
    app = new App "about"

    channel = msgBus.appChannel    

    class Router extends Marionette.AppRouter
        appRoutes:
            "about": "about"

    API =
        about: ->
            new Controller



    channel.on app.startEvent , ->
        console.log "handled: #{app.startEvent}"
        new Router
            controller: API
    app