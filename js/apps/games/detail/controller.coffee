define ["msgbus", "apps/games/detail/views", "controller/_base" ], (msgBus, Views, AppController) ->
    appChannel = msgBus.appChannel

    class Controller extends AppController
        initialize: (options) ->
            {gameName, gameModel} = options
            console.log options
            if gameModel is undefined
                gameModel = appChannel.request "games:searchName", gameName
                #console.log "GameModel", gameModel

            @layout = @getLayoutView gameModel: gameModel
            @listenTo @layout, "show", =>
                @showStreams gameModel

            @show @layout,
                loading:
                    entities: gameModel

        showStreams: (model) ->
            #view = @getGameView model
            appChannel.trigger "app:streams:list", @layout.getRegion('streamRegion'), model.get("game").name
            #@layout.getRegion('gameRegion').show view


        #getGameView: (model) ->
        #    new Views.Detail
        #        model: model

        getLayoutView: (options)->
            new Views.Layout options