define ["msgbus", "marionette", "backbone", "apps/games/list/controller","apps/games/detail/controller"], (msgBus, Marionette, Backbone, ListController, DetailController) ->
    channel = msgBus.appChannel    
    dataChannel = msgBus.dataChannel    

    appState = dataChannel.request "get:current:appstate"
    class Router extends Marionette.AppRouter
        appRoutes:
            "games": "list"
            "games/:id/detail": "detail"
        
            
    API =
        list: ->
            #only show games if logged in to TwitchTV api
            return Backbone.history.navigate("#d3", trigger:true) if appState.get("loginStatus") isnt true
            new ListController

        detail: (id, model) ->
            new DetailController
                gameName: id
                gameModel: model


    channel.on "app:game:detail", (model) ->
        Backbone.history.navigate "games/#{model.get("game").name}/detail", trigger:false
        API.detail model.get("game").name, model

    channel.on "start:games:app", ->
        new Router
            controller: API