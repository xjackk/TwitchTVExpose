define ["msgbus", "apps/games/detail/views", "controller/_base" ], (msgBus, Views, AppController) ->
    appChannel = msgBus.appChannel

    class Controller extends AppController
        initialize: (options={}) ->
            {@gameName, @gameModel} = options

            mainRegion = appChannel.request "default:region"
            
            # need to request if we get here via routing (back button via history...)
            @gameModel = appChannel.request "games:searchName", @gameName if @gameModel is undefined
            @streamEntities = appChannel.request "search:stream:entities", @gameName

            appChannel.trigger "when:fetched", [@gameModel, @streamEntities], =>
                viewdata=
                    gameModel:  @gameModel
                    streams:    @streamEntities

                layout = @getLayoutView viewdata

                mainRegion.show layout


            #@gRegion = @layout.getRegion "gameRegion"

            #@listenTo @gRegion, "show", (reg,view)=>
            #    console.log "region show:region:", reg
            #    console.log "region show:view:", view.model.get('game').name
            #    @showStreams view.model.get('game').name

            #@listenTo @layout, "render", =>
            #    console.log "controller listen render:", @gameName
            #$.wait(200) ->
            #@show @layout,
            #    loading:
            #        entities: [@gameModel, @streamEntities]



        getLayoutView: (options)->
            new Views.Layout options