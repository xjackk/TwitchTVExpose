(function() {
  var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  define(["backbone", "msgbus", "entities/appstate"], function(Backbone, msgBus, AppState) {
    var API, Game, GamesCollection, SearchCollection, SearchStreams, Stream, StreamCollection, StreamGet, dataChannel, games;
    dataChannel = msgBus.dataChannel;
    Game = (function(superClass) {
      extend(Game, superClass);

      function Game() {
        return Game.__super__.constructor.apply(this, arguments);
      }

      return Game;

    })(Backbone.Model);
    Stream = (function(superClass) {
      extend(Stream, superClass);

      function Stream() {
        return Stream.__super__.constructor.apply(this, arguments);
      }

      return Stream;

    })(Backbone.Model);
    StreamGet = (function(superClass) {
      extend(StreamGet, superClass);

      function StreamGet() {
        return StreamGet.__super__.constructor.apply(this, arguments);
      }

      StreamGet.prototype.parse = function(response) {
        return response.stream;
      };

      return StreamGet;

    })(Backbone.Model);
    SearchStreams = (function(superClass) {
      extend(SearchStreams, superClass);

      function SearchStreams() {
        return SearchStreams.__super__.constructor.apply(this, arguments);
      }

      SearchStreams.prototype.model = Stream;

      SearchStreams.prototype.parse = function(response) {
        return response.streams;
      };

      return SearchStreams;

    })(Backbone.Collection);
    SearchCollection = (function(superClass) {
      extend(SearchCollection, superClass);

      function SearchCollection() {
        return SearchCollection.__super__.constructor.apply(this, arguments);
      }

      SearchCollection.prototype.model = Game;

      SearchCollection.prototype.parse = function(response) {
        return response.games;
      };

      return SearchCollection;

    })(Backbone.Collection);
    GamesCollection = (function(superClass) {
      extend(GamesCollection, superClass);

      function GamesCollection() {
        return GamesCollection.__super__.constructor.apply(this, arguments);
      }

      GamesCollection.prototype.model = Game;

      GamesCollection.prototype.initialize = function() {
        dataChannel.reply("games:fetchmore", (function(_this) {
          return function() {
            return _this.moreGames();
          };
        })(this));
        this.limit = 50;
        this.offset = 0;
        this.loading = false;
        this.previousSearch = null;
        return this._total = null;
      };

      GamesCollection.prototype.moreGames = function() {
        var loaded;
        if (this.loading || this.length >= this._total) {
          return true;
        }
        this.loading = true;
        this.offset++;
        loaded = this.fetch({
          remove: false,
          data: {
            oauth_token: AppState.get("accessToken"),
            limit: this.limit,
            offset: this.offset * this.limit
          }
        });
        return $.when(loaded).then((function(_this) {
          return function() {
            return _this.loading = false;
          };
        })(this));
      };

      GamesCollection.prototype.searchName = function(_name) {
        return this.find(function(model) {
          return model.get("game").name === _name;
        });
      };

      GamesCollection.prototype.parse = function(response) {
        this._total = response._total;
        return response.top;
      };

      return GamesCollection;

    })(Backbone.Collection);
    StreamCollection = (function(superClass) {
      extend(StreamCollection, superClass);

      function StreamCollection() {
        return StreamCollection.__super__.constructor.apply(this, arguments);
      }

      StreamCollection.prototype.model = Stream;

      StreamCollection.prototype.initialize = function() {
        dataChannel.reply("streams:fetchmore", (function(_this) {
          return function() {
            return _this.moreStreams();
          };
        })(this));
        this.limit = 12;
        this.offset = 0;
        this.loading = false;
        this.previousSearch = null;
        return this._total = null;
      };

      StreamCollection.prototype.moreStreams = function() {
        var loaded;
        if (this.loading || this.length >= this._total) {
          return true;
        }
        this.loading = true;
        this.offset++;
        loaded = this.fetch({
          remove: false,
          data: {
            oauth_token: AppState.get("accessToken"),
            q: this.game,
            limit: this.limit,
            offset: this.offset * this.limit
          }
        });
        return $.when(loaded).then((function(_this) {
          return function() {
            return _this.loading = false;
          };
        })(this));
      };

      StreamCollection.prototype.parse = function(resp) {
        this._total = resp._total;
        return resp.streams;
      };

      return StreamCollection;

    })(Backbone.Collection);
    games = new GamesCollection;
    games.timeStamp = new Date();
    API = {
      getGames: function(url, params) {
        var elapsedSeconds;
        if (params == null) {
          params = {};
        }
        elapsedSeconds = Math.round(((new Date() - games.timeStamp) / 1000) % 60);
        if (elapsedSeconds > 45 || games.length === 0) {
          _.defaults(params, {
            oauth_token: AppState.get("accessToken")
          });
          games = new GamesCollection;
          games.timeStamp = new Date();
          games.url = "https://api.twitch.tv/kraken/" + url + "?callback=?";
          games.fetch({
            reset: true,
            data: params
          });
        }
        return games;
      },
      searchGames: function(url, params) {
        var sgames;
        if (params == null) {
          params = {};
        }
        _.defaults(params, {
          oauth_token: msgBus.reqres.request("get:current:token")
        });
        sgames = new SearchCollection;
        sgames.url = "https://api.twitch.tv/kraken/" + url + "?callback=?";
        sgames.fetch({
          reset: true,
          data: params
        });
        return sgames;
      },
      getStreams: function(url, params) {
        var streams;
        if (params == null) {
          params = {};
        }
        _.defaults(params, {
          oauth_token: AppState.get("accessToken")
        });
        streams = new StreamCollection;
        streams.game = params.q;
        streams.url = "https://api.twitch.tv/kraken/" + url + "?callback=?";
        streams.fetch({
          reset: true,
          data: params
        });
        return streams;
      },
      getStream: function(url, params) {
        var stream;
        if (params == null) {
          params = {};
        }
        console.log("getStream", url, params);
        _.defaults(params, {
          oauth_token: AppState.get("accessToken")
        });
        stream = new StreamGet;
        stream.url = "https://api.twitch.tv/kraken/" + url + "?callback=?";
        stream.fetch({
          data: params
        });
        return stream;
      }
    };
    dataChannel.reply("games:top:entities", function() {
      return API.getGames("games/top", {
        limit: 24,
        offset: 0
      });
    });
    dataChannel.reply("search:games", function(query) {
      return API.searchGames("search/games", {
        q: query,
        type: "suggest",
        live: false
      });
    });
    dataChannel.reply("games:searchName", function(query) {
      return games.searchName(query);
    });
    dataChannel.reply("search:stream:entities", function(game) {
      return API.getStreams("search/streams", {
        q: game,
        limit: 12,
        offset: 0
      });
    });
    return dataChannel.reply("search:stream:model", function(channel) {
      return API.getStream("streams/" + channel);
    });
  });

}).call(this);
