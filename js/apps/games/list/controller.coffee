define ["msgbus", "apps/games/list/views", "controller/_base", "backbone" ], (msgBus, Views, AppController, Backbone) ->
    class Controller extends AppController
        initialize: (options={})->
            @entities=msgBus.reqres.request "games:top:entities"
            @layout = @getLayoutView()

            @listenTo @layout, "show", =>
                console.log "show"
                @gameRegion() # @entities

            @listenTo @layout, "show:bubble", =>
                console.log "show:bubble"
                @gameBubbleRegion() # @entities

            @show @layout,
                loading:
                    entities: @entities

        gameRegion:   ->
            view = @getGameView @entities
            @listenTo view, "childview:game:item:clicked", (child, args) ->  # listen to events from itemview (we've overridden the eventnamePrefix to childview)
                #console.log "game:item:clicked => model", args.model
                msgBus.events.trigger "app:game:detail", args.model

            @listenTo view, "scroll:more", ->
                msgBus.reqres.request "games:fetchmore"

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