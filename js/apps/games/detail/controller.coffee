define ["msgbus", "apps/games/detail/views", "controller/_base" ], (msgBus, Views, AppController) ->
    appChannel = msgBus.appChannel

    class Controller extends AppController
        initialize: (options) ->
            {gameName, gameModel} = options

            if gameModel is undefined
                gameModel = appChannel.request "games:searchName", gameName
                #console.log "GameModel", gameModel

            @layout = @getLayoutView()
            @listenTo @layout, "show", =>
                @gameRegion gameModel

            @show @layout,
                loading:
                    entities: gameModel

        gameRegion: (model) ->
            view = @getGameView model
            appChannel.trigger "app:streams:list", @layout.getRegion('streamRegion'), model.get("game").name
            @layout.getRegion('gameRegion').show view


        getGameView: (model) ->
            new Views.Detail
                model: model

        getLayoutView: ->
            new Views.Layout