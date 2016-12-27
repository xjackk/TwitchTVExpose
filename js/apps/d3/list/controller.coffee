define ["apps/d3/list/views", "controller/_base"], (Views, AppController) ->

    class Controller extends AppController
        initialize:(options)->
            layout = new Views.Layout
            @show layout


            