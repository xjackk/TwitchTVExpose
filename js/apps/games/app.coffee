define ["msgbus", "marionette", "backbone", "apps/games/list/controller","apps/games/detail/controller"], (msgBus, Marionette, Backbone, ListController, DetailController) ->

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


    msgBus.events.on "app:game:detail", (model) ->
        Backbone.history.navigate "games/#{model.get("game").name}/detail", trigger:false
        console.log "APP:GAMES:LIST=> (from list controller) MODEL", model
        API.detail model.get("game").name, model

    msgBus.commands.setHandler "start:games:app", ->
        new Router
            controller: API


