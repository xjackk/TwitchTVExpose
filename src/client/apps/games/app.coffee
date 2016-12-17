define ["msgbus", "backbone", "marionette", "apps/games/list/controller","apps/games/detail/controller", "class/app"], (msgBus, Backbone, Marionette, ListController, DetailController, App) ->
    app = new App "games"
    appChannel = msgBus.appChannel    

    class Router extends Marionette.AppRouter
        appRoutes:
            "games": "list"
            "games/:id/detail": "detail"
            
    API =
        list: ->
            new ListController

        detail: (id, model) ->
            new DetailController
                gameName: id
                gameModel: model


    appChannel.on "app:game:detail", (model) ->
        Backbone.history.navigate "games/#{model.get("game").name}/detail", trigger:false
        API.detail model.get("game").name, model

    appChannel.on app.startEvent, ->
        console.log "handled: #{app.startEvent}"
        new Router
            controller: API

    app