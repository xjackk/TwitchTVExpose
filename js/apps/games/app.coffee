define ["msgbus", "marionette", "apps/games/list/controller", "apps/streams/app"], (msgBus, Marionette, Controller, StreamsController) ->

    class Router extends Marionette.AppRouter
        appRoutes:
            "games": "list"

    API =
        list: ->
            new Controller

    msgBus.commands.setHandler "start:games:app", ->
        new Router
            controller: API


