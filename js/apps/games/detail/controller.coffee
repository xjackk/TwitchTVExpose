define ["msgbus", "apps/games/detail/views", "controller/_base" ], (msgBus, Views, AppController) ->
    appChannel = msgBus.appChannel

    class Controller extends AppController
        initialize: (options={}) ->
            {@gameName, @gameModel} = options

            console.log 'start fetch'
            # need to request if we get here via routing (back button via history...)
            @gameModel = appChannel.request "games:searchName", @gameName if @gameModel is undefined
            @streamEntities = appChannel.request "search:stream:entities", @gameName

            appChannel.trigger "when:fetched", [@streamEntities], =>
                console.log 'end fetch'
                data=
                    gameModel:  @gameModel
                    streams:    @streamEntities

                # merge with passed in options
                #@mergeOptions options, data

                @layout = @getLayoutView data

                #@gRegion = @layout.getRegion "gameRegion"

                #@listenTo @gRegion, "show", (reg,view)=>
                #    console.log "region show:region:", reg
                #    console.log "region show:view:", view.model.get('game').name
                #    @showStreams view.model.get('game').name

                #@listenTo @layout, "render", =>
                #    console.log "controller listen render:", @gameName
                @show @layout #,
                    #loading:
                    #    entities: [data.dameModel, data.streams]

        #showStreams: (name) ->
        #    console.log "show streams for:", name
        #    appChannel.trigger "app:streams:list", @layout.getRegion('streamRegion'), name


        getLayoutView: (options)->
            new Views.Layout options