define ["msgbus", "apps/games/detail/views", "controller/_base", "backbone" ], (msgBus, Views, AppController, Backbone) ->
    class Controller extends AppController
        initialize: (options) ->
            {gameName, gameModel} = options
            #console.log "OPTIONS passed to detail controller", options

            if gameModel is undefined
                gameModel = msgBus.reqres.request "games:searchName", gameName
                #console.log "GameModel", gameModel

            @layout = @getLayoutView()
            @listenTo @layout, "show", =>
                @gameRegion gameModel

            @show @layout,
                loading:
                    entities: gameModel


        gameRegion: (model) ->
            view = @getGameView model
            msgBus.commands.execute "app:stream:list", @layout.streamRegion, model.get("game").name
            @layout.gameRegion.show view


        getGameView: (model) ->
            new Views.Detail
                model: model

        getLayoutView: ->
            new Views.Layout