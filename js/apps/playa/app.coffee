define ["msgbus", "backbone", "marionette", "apps/playa/show/controller"], (msgBus, Backbone, Marionette, Controller) ->

    class Router extends Marionette.AppRouter
        appRoutes:
            "player/:game/:channel": "show"

    API =
        show: (game,channel,model) ->
            new Controller
                game: game
                channel: channel
                model: model

    msgBus.commands.setHandler "start:playa:app", ->
        new Router
            controller: API

    msgBus.events.on "app:playa:show", (game,channel,streamModel) ->
        #console.log model.get("channel").display_name
        Backbone.history.navigate "player/#{streamModel.get("game")}/#{streamModel.get("channel").display_name}", trigger:false
        API.show streamModel.get("game"),streamModel.get("channel").display_name, streamModel