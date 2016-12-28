define ["msgbus", "backbone", "marionette", "apps/playa/show/controller"], (msgBus, Backbone, Marionette, Controller) ->
    appChannel = msgBus.appChannel

    class Router extends Marionette.AppRouter
        appRoutes:
            "player/:game/:channel": "show"

    API =
        show: (game,channel,model) ->
            new Controller
                #game: game
                channel: channel
                model: model

    appChannel.on "start:playa:app", ->
        new Router
            controller: API

    appChannel.on "app:playa:show", (streamModel) ->
        #console.log model.get("channel").display_name
        Backbone.history.navigate "player/#{streamModel.get("game")}/#{streamModel.get("channel").display_name}", trigger:false
        API.show streamModel.get("game"),streamModel.get("channel").display_name, streamModel