define ["apps/playa/show/views", "controller/_base"], (Views, AppController) ->

    class Controller extends AppController
        initialize:(options={})->
            {model} = options
            @layout = @getLayoutView()
            @listenTo @layout, "show", =>
                @playerRegion model
                @userRegion model
                @chatRegion model

            @show @layout

        playerRegion: (model)  ->
            player = @getPlayerView model
            @layout.playerRegion.show player

        chatRegion: (model)  ->
            chat = @getChatView model
            @layout.chatRegion.show chat

        userRegion: (model)  ->
            userView = @getUserView model
            @layout.userRegion.show userView

        getPlayerView: (model)  ->
            new Views.Player
                model: model

        getChatView: (model)  ->
            new Views.Chat
                model: model

        getUserView: (model)  ->
            new Views.User
                model: model

        getLayoutView: ->
            new Views.Layout
