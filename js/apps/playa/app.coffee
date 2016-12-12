define ["msgbus", "backbone", "marionette", "apps/playa/show/controller"], (msgBus, Backbone, Marionette, Controller) ->
    channel = msgBus.appChannel

    class Router extends Marionette.AppRouter
        appRoutes:
            "player/:game/:channel": "show"

    API =
        show: (game,channel,model) ->
            new Controller
                #game: game
                channel: channel
                model: model

    channel.on "start:playa:app", ->
        new Router
            controller: API

    channel.on "app:playa:show", (streamModel) ->
        Backbone.history.navigate "player/#{streamModel.get("game")}/#{streamModel.get("channel").display_name}", trigger:false
        API.show streamModel.get("game"),streamModel.get("channel").display_name, streamModel