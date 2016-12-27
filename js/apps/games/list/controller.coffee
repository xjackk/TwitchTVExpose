define ["msgbus", "apps/games/list/views", "controller/_base","entities/twitchtv"], (msgBus, Views, AppController) ->
    appChannel = msgBus.appChannel


    class Controller extends AppController
        initialize: (options={})->
            @entities = appChannel.request "games:top:entities"
            console.log @entities

            data=
                collection: @entities
            
            @layout = @getLayoutView data

            @listenTo @layout, "show:grid", =>
                @gameRegion @entities

            @listenTo @layout, "show:bubble", =>
                @gameBubbleRegion @entities

            @listenTo @layout, "childview:game:item:clicked", (cv) ->  # listen to events from itemview (we've overridden the eventnamePrefix to childview)


            @show @layout,
                loading:
                    entities: @entities

        gameRegion:  (games) ->
            view = @getGameView games
            #@listenTo view, "childview:game:item:clicked", (child, args) ->  # listen to events from itemview (we've overridden the eventnamePrefix to childview)
            #    appChannel.trigger "app:game:detail", args.model

            @listenTo view, "scroll:more", ->
                appChannel.request "games:fetchmore"

            @layout.getRegion("topGameList").show view

        gameBubbleRegion:  (collection) ->
            view = @getBubbleView @entities
            @layout.getRegion("topGameList").show view

        getBubbleView: (collection) ->
            new Views.GamesBubbleView
                collection: collection


        getGameView: (collection) ->
            new Views.TopGameList
                collection: collection

        getLayoutView: (options={})->
            new Views.Layout options