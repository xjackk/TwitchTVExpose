# LS currency app/module
define ["msgbus", "marionette", "apps/about/show/controller"], (msgBus, Marionette, Controller) ->

    class Router extends Marionette.AppRouter
        appRoutes:
            "about": "myWanker"

    API =
        myWanker: ->
            new Controller

    msgBus.commands.setHandler "start:about:app", ->
        new Router
            controller: API