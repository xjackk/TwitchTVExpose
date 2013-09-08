define ["apps/playa/show/views", "controller/_base"], (Views, AppController) ->

    class Controller extends AppController
        initialize:(options={})->
            {model} = options
            @layout = @getLayoutView()
            @listenTo @layout, "show", =>
                @playerRegion model
                @userRegion model

            @show @layout

        playerRegion: (model)  ->
            player = @getPlayerView model
            @layout.playerRegion.show player

        userRegion: (model)  ->
            userView = @getUserView model
            @layout.userRegion.show userView

        getPlayerView: (model)  ->
            new Views.Player
                model: model

        getUserView: (model)  ->
            new Views.User
                model: model

        getLayoutView: ->
            new Views.Layout
