define ["msgbus", "apps/games/detail/views", "controller/_base" ], (msgBus, Views, AppController) ->
    appChannel = msgBus.appChannel

    class Controller extends AppController
        initialize: (options={}) ->
            {@gameName, gameModel} = options

            # need to request if we get here via routing (back button via history...)
            gameModel = appChannel.request "games:searchName", @gameName if gameModel is undefined

            # pass this into our layout
            data =
                gameModel: gameModel

            # merge with passed in options
            @mergeOptions options, data

            @layout = @getLayoutView options

            @listenTo @layout, "render", =>
                console.log "controller listen render:", @gameName
                @showStreams @gameName

            @show @layout,
                loading: 
                    entities: gameModel

        showStreams: (name) ->
            console.log "Name:", name
            appChannel.trigger "app:streams:list", @layout.getRegion('streamRegion'), name


        getLayoutView: (options)->
            new Views.Layout options