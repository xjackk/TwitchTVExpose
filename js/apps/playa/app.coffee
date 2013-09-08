define ["msgbus", "backbone", "marionette", "apps/playa/show/controller"], (msgBus, Backbone, Marionette, Controller) ->

    class Router extends Marionette.AppRouter
        appRoutes:
            "player": "show"

    API =
        show: (model) ->
            new Controller
                model: model

    msgBus.commands.setHandler "start:playa:app", ->
        new Router
            controller: API

    msgBus.events.on "app:playa:show", (model) ->
        #console.log model.get("channel").display_name
        Backbone.history.navigate "games/player/#{model.get("game")}/#{model.get("channel").display_name}", trigger:false
        API.show model