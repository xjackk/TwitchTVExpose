define ["msgbus", "apps/games/list/views", "controller/_base","entities/twitchtv"], (msgBus, Views, AppController) ->
    appChannel = msgBus.appChannel


    class Controller extends AppController
        initialize: (options={})->
            @entities = appChannel.request "games:top:entities"
            
            @layout = @getLayoutView collection: @entities

            @listenTo @layout, "show:grid", =>
                @showGridView @entities

            @listenTo @layout, "show:bubble", =>
                @showBubbleView @entities

            @listenTo @layout, "scroll:more", ->
                appChannel.request "games:fetchmore"

            @show @layout,
                loading:
                    entities: @entities

        showGridView:  (games) ->
            gView = @getGridView games
            @layout.getRegion("topGameList").show gView

        showBubbleView:  (collection) ->
            bView = @getBubbleView @entities
            @layout.getRegion("topGameList").show bView


        getBubbleView: (collection) ->
            new Views.GamesBubbleView
                collection: collection

        getGridView: (collection) ->
            new Views.GameGridView
                collection: collection

        #master layout, a view with regions
        getLayoutView: (options={})->
            new Views.Layout options