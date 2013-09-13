define ["apps/d3/list/views", "controller/_base"], (Views, AppController) ->

    class Controller extends AppController
        initialize:(options)->
            @layout = @getLayoutView()
            @listenTo @layout, "show", =>
                @visRegion()
            @show @layout

        visRegion:  ->
            region1 = @getDataVisView1()
            region2 = @getDataVisView2()
            @layout.dataVisRegion1.show region1
            @layout.dataVisRegion2.show region2

        getDataVisView1:  ->
            new Views.DataVis1

        getDataVisView2:  ->
            new Views.DataVis2

        getLayoutView: ->
            new Views.Layout
