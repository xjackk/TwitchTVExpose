define ["entities/_backbone", "msgbus"], (_Backbone, msgBus ) ->
    # this _fetch is our private property added to overridden config backbone sync

    class Game extends _Backbone.Model
    class Stream extends _Backbone.Model

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
                remove: false  # remove false appends new games to the existing collection
                data:
                    oauth_token: msgBus.reqres.request "get:current:token"
                    limit: @limit
                    offset: @offset * @limit
            $.when(loaded).then =>
                @loading=false
                console.log "Loaded page", @offset+1, "Games fetched so far", @length, "Total games available to fetch ", @_total

        searchName: (_name)->
            @find (model)->
                model.get("game").name is _name


        parse: (response) ->
            {@_total}=response  # pull of the _total items in the list here
            response.top        # the .top array get loaded into our backbone collection


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
            #console.log "fetching page #{@offset+1} of games"
            loaded = @fetch
                remove: false  # remove false appends new games to the existing collection
                data:
                    oauth_token: msgBus.reqres.request "get:current:token"
                    q: @game
                    limit: @limit
                    offset: @offset * @limit
            $.when(loaded).then =>
                @loading=false
                #console.log "Loaded page", @offset+1, "Streams fetched so far", @length, "Total streams available to fetch ", @_total


        parse: (resp) ->
            {@_total}=resp
            resp.streams

    # keep a permanent copy of the games collection only refresh every 45 seconds for speedier page action
    games = new GamesCollection
    games.timeStamp = new Date()  #archive

    API =
        getGames: (url, params = {}) ->
            #now = new Date()
            #diff = ((new Date() - games.timeStamp ) / 1000)
            elapsedSeconds = Math.round(((new Date() - games.timeStamp ) / 1000) % 60)
            #console.log "elapsed seconds", elapsedSeconds, now, games.timeStamp
            if elapsedSeconds > 45 or games.length is 0
                _.defaults params,
                    oauth_token: msgBus.reqres.request "get:current:token"
                games = new GamesCollection
                games.timeStamp = new Date()  #new time stamp
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
            streams.game=params.q
            streams.url = "https://api.twitch.tv/kraken/#{url}?callback=?"
            streams.fetch
                reset: true
                data: params
            streams

    msgBus.reqres.setHandler "games:top:entities", ->
        API.getGames "games/top",
            limit: 50
            offset: 0

    # shiny and new  this doesn't seem to work...
    msgBus.reqres.setHandler "game:search", (query)->
        API.searchGames "games/search",
            q: encodeURIComponent query
            type: "suggest"

    msgBus.reqres.setHandler "games:searchName", (query)->
        games.searchName query

    msgBus.reqres.setHandler "search:stream:entities", (game)->
        API.getStreams "search/streams",
            q: game
            limit: 12
            offset: 0


# Use this in your browser's console to initialize a JSONP request to see the API in action.
# $.getJSON("http://api.rottentomatoes.com/api/public/v1.0/movies.json?callback=?", {apikey: "vzjnwecqq7av3mauck2238uj", q: "shining"})