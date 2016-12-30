// Generated by CoffeeScript 1.12.2
(function() {
  var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  define(["backbone", "msgbus", "nprogress"], function(Backbone, msgBus, NP) {
    var API, Game, GamesCollection, SearchCollection, SearchStreams, Stream, StreamCollection, StreamGet, StreamSummary, appChannel, games, streamSummary;
    appChannel = msgBus.appChannel;
    StreamSummary = (function(superClass) {
      extend(StreamSummary, superClass);

      function StreamSummary() {
        return StreamSummary.__super__.constructor.apply(this, arguments);
      }

      StreamSummary.prototype.defaults = {
        fetched: 0,
        total: 0
      };

      return StreamSummary;

    })(Backbone.Model);
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

      SearchStreams.prototype.initialize = function() {
        this.listenTo(this, 'request', function() {
          return NP.start();
        });
        return this.listenTo(this, 'sync error', function() {
          return NP.done();
        });
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

      SearchCollection.prototype.initialize = function() {
        this.listenTo(this, 'request', function() {
          return NP.start();
        });
        return this.listenTo(this, 'sync error', function() {
          return NP.done();
        });
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
        this.listenTo(this, 'request', function() {
          return NP.start();
        });
        this.listenTo(this, 'sync error', function() {
          return NP.done();
        });
        appChannel.reply("games:fetchmore", (function(_this) {
          return function() {
            return _this.moreGames();
          };
        })(this));
        this.limit = 24;
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
            oauth_token: appChannel.request("get:current:token"),
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
        this.listenTo(this, 'request', function() {
          return NP.start();
        });
        this.listenTo(this, 'sync error', function() {
          return NP.done();
        });
        appChannel.reply("streams:fetchmore", (function(_this) {
          return function() {
            return _this.moreStreams();
          };
        })(this));
        this.limit = 24;
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
            oauth_token: appChannel.request("get:current:token"),
            q: this.game,
            limit: this.limit,
            offset: this.offset * this.limit
          }
        });
        return $.when(loaded).then((function(_this) {
          return function() {
            _this.loading = false;
            return console.log("Loaded page", _this.offset + 1, "Streams fetched so far", _this.length, "Total streams available to fetch ", _this._total);
          };
        })(this));
      };

      StreamCollection.prototype.parse = function(resp) {
        this._total = resp._total;
        streamSummary.set({
          "fetched": this.length + resp.streams.length,
          "total": this._total
        });
        console.log(streamSummary);
        return resp.streams;
      };

      return StreamCollection;

    })(Backbone.Collection);
    games = new GamesCollection;
    games.timeStamp = new Date();
    streamSummary = new StreamSummary;
    API = {
      getGames: function(url, params) {
        var elapsedSeconds;
        if (params == null) {
          params = {};
        }
        elapsedSeconds = Math.round(((new Date() - games.timeStamp) / 1000) % 60);
        if (elapsedSeconds > 45 || games.length === 0) {
          _.defaults(params, {
            oauth_token: appChannel.request("get:current:token")
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
          oauth_token: appChannel.request("get:current:token")
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
          oauth_token: appChannel.request("get:current:token")
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
        _.defaults(params, {
          oauth_token: appChannel.request("get:current:token")
        });
        stream = new StreamGet;
        stream.url = "https://api.twitch.tv/kraken/" + url + "?callback=?";
        stream.fetch({
          data: params
        });
        return stream;
      }
    };
    appChannel.reply("games:top:entities", function() {
      return API.getGames("games/top", {
        limit: 24,
        offset: 0
      });
    });
    appChannel.reply("search:games", function(query) {
      return API.searchGames("search/games", {
        q: query,
        type: "suggest",
        live: false
      });
    });
    appChannel.reply("games:searchName", function(query) {
      return games.searchName(query);
    });
    appChannel.reply("search:stream:entities", function(game) {
      return API.getStreams("search/streams", {
        q: game,
        limit: 20,
        offset: 0
      });
    });
    appChannel.reply("search:stream:model", function(channel) {
      return API.getStream("streams/" + channel);
    });
    return appChannel.reply("stream:summary:model", function() {
      return streamSummary;
    });
  });

}).call(this);
