define ["msgbus", "backbone", "marionette", "apps/playa/show/controller", "class/app"], (msgBus, Backbone, Marionette, Controller, App) ->
    app = new App "playa"
    
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

    channel.on app.startEvent, ->
        console.log "handled: #{app.startEvent}"
        new Router
            controller: API

    channel.on "app:playa:show", (streamModel) ->
        Backbone.history.navigate "player/#{streamModel.get("game")}/#{streamModel.get("channel").display_name}", trigger:false
        API.show streamModel.get("game"),streamModel.get("channel").display_name, streamModel
    
    app