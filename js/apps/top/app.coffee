# LS currency app/module
define ["msgbus", "marionette", "apps/top/list/controller"], (msgBus, Marionette, Controller) ->

    class Router extends Marionette.AppRouter
        appRoutes:
            "top": "myWanker"

    API =
        myWanker: ->
            new Controller

    msgBus.commands.setHandler "start:top:app", ->
        new Router
            controller: API