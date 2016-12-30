define ["backbone", "msgbus"], (Backbone, msgBus) ->
    appChannel = msgBus.appChannel

    # this _fetch is our private property added to overridden config backbone sync

    class StreamSummary extends Backbone.Model
        defaults:
            fetched: 0
            total: 0
    
    class Game extends Backbone.Model
    class Stream extends Backbone.Model

    # differennt class to handle parse of .stream object from the twitch API: looking for a single model
    class StreamGet extends Backbone.Model
        parse: (response) ->
            response.stream

    class SearchStreams extends Backbone.Collection
        model: Stream
        parse: (response) ->
            response.streams


    class SearchCollection extends Backbone.Collection
        model: Game
        parse: (response) ->
            response.games


    class GamesCollection extends Backbone.Collection
        model: Game

        initialize: ->
            appChannel.reply "games:fetchmore", =>
                @moreGames()

            @limit = 24
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
                    oauth_token: appChannel.request "get:current:token"
                    limit: @limit
                    offset: @offset * @limit

            $.when(loaded).then =>
                @loading=false
                #console.log "Loaded page", @offset+1, "Games fetched so far", @length, "Total games available to fetch ", @_total,


        searchName: (_name)->
            @find (model)->
                model.get("game").name is _name


        parse: (response) ->
            {@_total}=response
            response.top


    class StreamCollection extends Backbone.Collection
        model: Stream

        initialize: ->
            appChannel.reply "streams:fetchmore", =>
                @moreStreams()

            @limit = 24
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
                    oauth_token: appChannel.request "get:current:token"
                    q: @game
                    limit: @limit
                    offset: @offset * @limit
            $.when(loaded).then =>
                @loading=false
                console.log "Loaded page", @offset+1, "Streams fetched so far", @length, "Total streams available to fetch ", @_total,


        parse: (resp) ->
            {@_total}=resp
            streamSummary.set "fetched": @length+resp.streams.length, "total": @_total
            #console.log streamSummary
            
            resp.streams

    # caching timers initialize
    games = new GamesCollection
    games.timeStamp = new Date()

    streamSummary = new StreamSummary



    #PUBLIC API
    API =
        getGames: (url, params = {}) ->
            #45 seconds elapsed time between TOP game fetches
            elapsedSeconds = Math.round(((new Date() - games.timeStamp ) / 1000) % 60)
            if elapsedSeconds > 45 or games.length is 0
                _.defaults params,
                    oauth_token: appChannel.request "get:current:token"
                games = new GamesCollection
                games.timeStamp = new Date()
                games.url = "https://api.twitch.tv/kraken/#{url}?callback=?"
                games.fetch
                    reset: true
                    data: params
            games

        searchGames: (url, params = {}) ->
            _.defaults params,
                oauth_token: appChannel.request "get:current:token"
            sgames = new SearchCollection
            sgames.url = "https://api.twitch.tv/kraken/#{url}?callback=?"
            sgames.fetch
                reset: true
                data: params
            sgames


        getStreams: (url, params = {}) ->
            _.defaults params,
                oauth_token: appChannel.request "get:current:token"
            streams = new StreamCollection
            streams.game=params.q #tack this on/custom class property
            streams.url = "https://api.twitch.tv/kraken/#{url}?callback=?"
            streams.fetch
                reset: true
                data: params
            streams

        # get stream by channel
        getStream: (url, params = {}) ->
            _.defaults params,
                oauth_token: appChannel.request "get:current:token"
            stream = new StreamGet # model
            stream.url = "https://api.twitch.tv/kraken/#{url}?callback=?"
            stream.fetch
                data: params
            stream

    # initial collection search 'top games' twitchAPI
    appChannel.reply "games:top:entities", ->
        API.getGames "games/top",
            limit: 24
            offset: 0

    #implement TWITCHAPI call
    appChannel.reply "search:games", (query)->
        API.searchGames "search/games",
            q: query #encodeURIComponent query
            type: "suggest"
            live: false

    # search internal cached collection for a game models, speed up the UI
    appChannel.reply "games:searchName", (query)->
        games.searchName query

    #search for streams by game
    appChannel.reply "search:stream:entities", (game)->
        API.getStreams "search/streams",
            q: game
            limit: 20
            offset: 0

    # twitchAPI, grab a channels live stream
    appChannel.reply "search:stream:model", (channel)->
        API.getStream "streams/#{channel}"

    appChannel.reply "stream:summary:model", ->
        streamSummary

