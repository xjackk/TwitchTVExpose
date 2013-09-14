define ["entities/_backbone", "msgbus"], (_Backbone, msgBus ) ->
    # this _fetch is our private property added to overridden config backbone sync

    class Game extends _Backbone.Model
    class Stream extends _Backbone.Model

    class GamesCollection extends _Backbone.Collection
        model: Game

        initialize: ->
            #msgBus.events.on "games:fetchmore", =>
            #    @moreGames()

            @limit = 20
            @offset = 0
            @loading = false
            @previousSearch = null
            @_total = null

        moreGames: ->
            return true  if @loading or @length >= @_total  #length is the size of this collection, _total is parsed from the API
            @loading=true
            @offset++
            console.log "fetching page #{@offset+1} of games"
            games = @fetch
                remove: false  # remove false appends new games to the existing collection
                data:
                    oauth_token: msgBus.reqres.request "get:current:token"
                    limit: @limit
                    offset: @offset
            $.when(games).then =>
                @loading=false
                console.log "Page#: ", @offset+1, "Games fetched:", @length, "Total Games Available to fetch ", @_total

        parse: (response) ->
            {@_total}=response  # pull of the _total items in the list here
            response.top        # the .top array get loaded into our backbone collection


    class StreamCollection extends _Backbone.Collection
        model: Stream

        parse: (resp) ->
            #console.log resp
            resp.streams

    API =
        games = new GamesCollection
        page=0

        getGames: (url, params = {}) ->
            page=0
            _.defaults params,
                oauth_token: msgBus.reqres.request "get:current:token"
            games.url = "https://api.twitch.tv/kraken/#{url}?callback=?"
            games.fetch
                reset: true
                data: params
            games

        moreGames: (url) ->
            page++
            games.url = "https://api.twitch.tv/kraken/#{url}?callback=?"
            games.fetch
                remove:false  #
                data:
                    oauth_token: msgBus.reqres.request "get:current:token"
                    limit:20
                    offset: page
            games


        getStreams: (url, params = {}) ->
            _.defaults params,
                oauth_token: msgBus.reqres.request "get:current:token"
            streams = new StreamCollection
            streams.url = "https://api.twitch.tv/kraken/#{url}?callback=?"
            streams.fetch
                reset: true
                data: params
            streams

    msgBus.reqres.setHandler "games:fetchmore", ->
        API.moreGames "games/top"


    msgBus.reqres.setHandler "games:top:entities", ->
        API.getGames "games/top",
            limit: 20
            offset: 0

    msgBus.reqres.setHandler "search:stream:entities", (game)->
        API.getStreams "search/streams",
            q: game
            limit: 12
            offset: 0


#    App.reqres.setHandler "search:movie:entities", (searchTerm) ->
#        #update me
#    	API.getMovies "movies",
#    		q: $.trim(searchTerm)

#    App.reqres.setHandler "theatre:movie:entities", ->
#        #update me
#    	API.getMovies "lists/movies/in_theaters",
#    		page_limit: 10
#    		page: 1

#    App.reqres.setHandler "upcoming:movie:entities", ->
#        #update me
#    	API.getMovies "lists/movies/upcoming",
#    		page_limit: 10
#    		page: 1

# Use this in your browser's console to initialize a JSONP request to see the API in action.
# $.getJSON("http://api.rottentomatoes.com/api/public/v1.0/movies.json?callback=?", {apikey: "vzjnwecqq7av3mauck2238uj", q: "shining"})