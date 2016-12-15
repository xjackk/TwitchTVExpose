define ["apps/playa/show/views", "controller/_base","msgbus"], (Views, AppController, msgBus) ->

    dataChannel = msgBus.dataChannel
    console.log "playa:", Views

    class Controller extends AppController
        initialize:(options={})->
            {channel, model} = options
            model = dataChannel.request "search:stream:model", channel if model is undefined

            @layout = @getLayoutView()
            @listenTo @layout, "show", =>
                @playerRegion model
                @userRegion model
                @chatRegion model

            @show @layout,
                loading:
                    entities: model

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
