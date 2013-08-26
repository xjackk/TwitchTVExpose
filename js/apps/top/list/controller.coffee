# db list controller
define ["msgbus", "apps/top/list/views", "controller/_base"], (msgBus, Views, AppController) ->
    # the module API will pass in the glogal collection of ccys
    class Controller extends AppController
        initialize:(options)->
            entities=msgBus.reqres.request "games:top:entities"
            @layout = @getLayoutView()

            @listenTo @layout, "show", =>
                @gameRegion entities

            @show @layout,
                loading:
                    entities: entities

        gameRegion: (collection)  ->
            view = @getGameView collection
            @layout.topGameRegion.show view

        getGameView: (collection) ->
            new Views.TopGameList
                collection: collection

        getLayoutView: ->
            new Views.Layout