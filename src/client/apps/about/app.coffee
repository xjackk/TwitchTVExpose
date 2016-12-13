define ["msgbus", "marionette", "apps/about/show/controller"], (msgBus, Marionette, Controller) ->
    channel = msgBus.appChannel    

    class Router extends Marionette.AppRouter
        appRoutes:
            "about": "about"

    API =
        about: ->
            new Controller

    channel.on "start:about:app", ->
        new Router
            controller: API