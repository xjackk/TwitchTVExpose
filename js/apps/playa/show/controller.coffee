define ["apps/playa/show/views", "controller/_base","msgbus"], (Views, AppController, msgBus) ->
    appChannel = msgBus.appChannel

    class Controller extends AppController
        initialize:(options={})->
            {channel, model} = options
            console.log "Player Controller  options", options
            #console.log "game", game, "channel", channel, "model", model

            #if model is undefined
            #    console.log "searching for ", channel
            model = appChannel.request "search:stream:model", channel if model is undefined

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
            @layout.getRegion('playerRegion').show player

        chatRegion: (model)  ->
            chat = @getChatView model
            @layout.getRegion('chatRegion').show chat

        userRegion: (model)  ->
            userView = @getUserView model
            @layout.getRegion('userRegion').show userView

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
