define ["entities/_backbone", "msgbus"], (_Backbone, msgBus ) ->
    # this _fetch is our private property added to overridden config backbone sync

    class Game extends _Backbone.Model
    class Stream extends _Backbone.Model

    class StreamGet extends _Backbone.Model
        parse: (response) ->
            response.stream

    class SearchStreams extends _Backbone.Collection
        model: Stream
        parse: (response) ->
            response.streams

    class SearchCollection extends _Backbone.Collection
        model: Game
        parse: (response) ->
            response.games

    class GamesCollection extends _Backbone.Collection
        model: Game

        initialize: ->
            msgBus.reqres.setHandler "games:fetchmore", =>
                @moreGames()

            @limit = 50
            @offset = 0
            @loading = false
            @previousSearch = null
            @_total = null

        moreGames: ->
            return true  if @loading or @length >= @_total
            @loading=true
            @offset++
            #console.log "fetching page #{@offset+1} of games"
            loaded = @fetch
                remove: false
                data:
                    oauth_token: msgBus.reqres.request "get:current:token"
                    limit: @limit
                    offset: @offset * @limit
            $.when(loaded).then =>
                @loading=false
                #console.log "Loaded page", @offset+1, "Games fetched so far", @length, "Total games available to fetch ", @_total

        searchName: (_name)->
            @find (model)->
                model.get("game").name is _name


        parse: (response) ->
            {@_total}=response
            response.top


    class StreamCollection extends _Backbone.Collection
        model: Stream

        initialize: ->
            msgBus.reqres.setHandler "streams:fetchmore", =>
                @moreStreams()

            @limit = 12
            @offset = 0
            @loading = false
            @previousSearch = null
            @_total = null

        moreStreams: ->
            return true  if @loading or @length >= @_total
            @loading=true
            @offset++
            loaded = @fetch
                remove: false
                data:
                    oauth_token: msgBus.reqres.request "get:current:token"
                    q: @game
                    limit: @limit
                    offset: @offset * @limit
            $.when(loaded).then =>
                @loading=false


        parse: (resp) ->
            {@_total}=resp
            resp.streams

    games = new GamesCollection
    games.timeStamp = new Date()


    API =
        getGames: (url, params = {}) ->
            elapsedSeconds = Math.round(((new Date() - games.timeStamp ) / 1000) % 60)
            if elapsedSeconds > 45 or games.length is 0
                _.defaults params,
                    oauth_token: msgBus.reqres.request "get:current:token"
                games = new GamesCollection
                games.timeStamp = new Date()
                games.url = "https://api.twitch.tv/kraken/#{url}?callback=?"
                games.fetch
                    reset: true
                    data: params
            games

        searchGames: (url, params = {}) ->
            _.defaults params,
                oauth_token: msgBus.reqres.request "get:current:token"
            sgames = new SearchCollection
            sgames.url = "https://api.twitch.tv/kraken/#{url}?callback=?"
            sgames.fetch
                reset: true
                data: params
            sgames


        getStreams: (url, params = {}) ->
            _.defaults params,
                oauth_token: msgBus.reqres.request "get:current:token"
            streams = new StreamCollection
            streams.game=params.q #tack this on/custom class property
            streams.url = "https://api.twitch.tv/kraken/#{url}?callback=?"
            streams.fetch
                reset: true
                data: params
            streams

        # get stream by channel
        getStream: (url, params = {}) ->
            console.log "getStream", url, params
            _.defaults params,
                oauth_token: msgBus.reqres.request "get:current:token"
            stream = new StreamGet # model
            stream.url = "https://api.twitch.tv/kraken/#{url}?callback=?"
            stream.fetch
                data: params
            stream


    msgBus.reqres.setHandler "games:top:entities", ->
        API.getGames "games/top",
            limit: 12
            offset: 0

    msgBus.reqres.setHandler "search:games", (query)->
        API.searchGames "search/games",
            q: query #encodeURIComponent query
            type: "suggest"
            live: false


    msgBus.reqres.setHandler "games:searchName", (query)->
        games.searchName query

    msgBus.reqres.setHandler "search:stream:entities", (game)->
        API.getStreams "search/streams",
            q: game
            limit: 12
            offset: 0

    msgBus.reqres.setHandler "search:stream:model", (channel)->
        API.getStream "streams/#{channel}"
