define ["msgbus", "marionette", "apps/about/show/controller"], (msgBus, Marionette, Controller) ->
    appChannel = msgBus.appChannel

    class Router extends Marionette.AppRouter
        appRoutes:
            "about": "about"

    API =
        about: ->
            new Controller
                region: appChannel.request "default:region"

    appChannel.on "start:about:app", ->
        new Router
            controller: API