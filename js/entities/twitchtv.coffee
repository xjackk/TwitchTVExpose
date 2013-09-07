# TO DO:  Jack.. investigate the TwitchTV api.  do you need and API key and the uri stuff etc
define ["entities/_backbone", "msgbus",], (_Backbone, msgBus ) ->
    # this _fetch is our private property added to overridden config backbone sync

    class Game extends _Backbone.Model

    class Stream extends _Backbone.Model

    class GamesCollection extends _Backbone.Collection
        model: Game

        parse: (resp) ->
            resp.top

    class StreamCollection extends _Backbone.Collection
        model: Stream

        parse: (resp) ->
            console.log resp
            resp.streams


    API =
        getGames: (url, params = {}) ->
            _.defaults params,
                oauth_token: msgBus.reqres.request "get:current:token"
                #country: "us"
            games = new GamesCollection
            games.url = "https://api.twitch.tv/kraken/#{url}?callback=?"
            games.fetch
                reset: true
                data: params
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

    msgBus.reqres.setHandler "games:top:entities", ->
        API.getGames "games/top",
            limit: 10

    msgBus.reqres.setHandler "search:stream:entities", (game)->
        API.getStreams "search/streams",
            q: game
            limit: 10

###
    App.reqres.setHandler "search:movie:entities", (searchTerm) ->
        #update me
    	API.getMovies "movies",
    		q: $.trim(searchTerm)

    App.reqres.setHandler "theatre:movie:entities", ->
        #update me
    	API.getMovies "lists/movies/in_theaters",
    		page_limit: 10
    		page: 1

    App.reqres.setHandler "upcoming:movie:entities", ->
        #update me
    	API.getMovies "lists/movies/upcoming",
    		page_limit: 10
    		page: 1
###
    # Use this in your browser's console to initialize a JSONP request to see the API in action.
    # $.getJSON("http://api.rottentomatoes.com/api/public/v1.0/movies.json?callback=?", {apikey: "vzjnwecqq7av3mauck2238uj", q: "shining"})