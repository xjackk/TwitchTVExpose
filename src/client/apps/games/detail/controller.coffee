define ["msgbus", "apps/games/detail/views", "controller/_base" ], (msgBus, Views, AppController) ->
    dataChannel = msgBus.dataChannel    
    console.log "games detail", Views

    class Controller extends AppController

        initialize: (options) ->
            {gameName, gameModel} = options
            #console.log "OPTIONS passed to detail controller", options

            if gameModel is undefined
                gameModel = dataChannel.request "games:searchName", gameName

            @layout = @getLayoutView()
            @listenTo @layout, "show", =>
                @gameRegion gameModel

            @show @layout,
                loading:
                    entities: gameModel


        gameRegion: (model) ->
            view = @getGameView model
            dataChannel.trigger "app:stream:list", @layout.streamRegion, model.get("game").name
            @layout.gameRegion.show view


        getGameView: (model) ->
            new Views.Detail
                model: model

        getLayoutView: ->
            new Views.Layout