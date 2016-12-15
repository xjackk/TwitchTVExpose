define ["msgbus", "apps/games/list/views", "controller/_base"], (msgBus, Views, AppController) ->
    dataChannel = msgBus.dataChannel    
    console.log "games list", Views

    class Controller extends AppController
        initialize: (options={})->
            @entities = channel.request "games:top:entities"
            @layout = @getLayoutView()

            @listenTo @layout, "show", =>
                @gameRegion() # @entities

            @listenTo @layout, "show:bubble", =>
                @gameBubbleRegion() # @entities

            @show @layout,
                loading:
                    entities: @entities

        gameRegion:   ->
            view = @getGameView @entities
            @listenTo view, "childview:game:item:clicked", (child, args) ->  # listen to events from itemview (we've overridden the eventnamePrefix to childview)
                #console.log "game:item:clicked => model", args.model
                dataChannel.trigger "app:game:detail", args.model

            @listenTo view, "scroll:more", ->
                dataChannel.request "games:fetchmore"

            @layout.gameRegion.show view

        gameBubbleRegion:   ->
            view = @getBubbleView @entities
            @layout.gameRegion.show view

        getBubbleView: (collection) ->
            new Views.GamesBubbleView
                collection: collection

        getGameView: (collection) ->
            new Views.TopGameList
                collection: collection

        getLayoutView: ->
            new Views.Layout
            