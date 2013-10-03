define ["apps/d3/list/views", "controller/_base"], (Views, AppController) ->

    class Controller extends AppController
        initialize:(options)->
            @layout = @getLayoutView()
            @listenTo @layout, "show", =>
                @visRegion()
            @show @layout

        visRegion:  ->
            view = @getDataVisView()
            @layout.dataVisRegion1.show view

        getDataVisView:  ->
            new Views.DataVis

        getLayoutView: ->
            new Views.Layout