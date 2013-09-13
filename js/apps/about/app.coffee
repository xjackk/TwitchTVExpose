define ["msgbus", "marionette", "apps/about/show/controller"], (msgBus, Marionette, Controller) ->

    class Router extends Marionette.AppRouter
        appRoutes:
            "about": "kyliesmellsgreat"

    API =
        kyliesmellsgreat: ->
            new Controller

    msgBus.commands.setHandler "start:about:app", ->
        new Router
            controller: API