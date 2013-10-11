define ["apps/playa/show/views", "controller/_base","msgbus"], (Views, AppController, msgBus) ->

    class Controller extends AppController
        initialize:(options={})->
            {game, channel, model} = options
            console.log "Player Controller options", options
            console.log "game", game, "channel", channel, "model", model

            if model is undefined
                console.log "searching for ", game
                games = msgBus.reqres.request "search:games", game
                entities=games
            else
                entities=model



            @layout = @getLayoutView()
            @listenTo @layout, "show", =>
                if model is undefined
                    console.log "GAMES",games
                    model=games.first()
                    console.log "MODEL",model
                @playerRegion model
                @userRegion model
                @chatRegion model

            @show @layout,
                loading:
                    entities: entities

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
