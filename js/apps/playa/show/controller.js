// Generated by CoffeeScript 1.6.3
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(["apps/playa/show/views", "controller/_base", "msgbus"], function(Views, AppController, msgBus) {
    var Controller, _ref;
    return Controller = (function(_super) {
      __extends(Controller, _super);

      function Controller() {
        _ref = Controller.__super__.constructor.apply(this, arguments);
        return _ref;
      }

      Controller.prototype.initialize = function(options) {
        var channel, entities, game, games, model,
          _this = this;
        if (options == null) {
          options = {};
        }
        game = options.game, channel = options.channel, model = options.model;
        console.log("Player Controller options", options);
        console.log("game", game, "channel", channel, "model", model);
        if (model === void 0) {
          console.log("searching for ", game);
          games = msgBus.reqres.request("search:games", game);
          entities = games;
        } else {
          entities = model;
        }
        this.layout = this.getLayoutView();
        this.listenTo(this.layout, "show", function() {
          if (model === void 0) {
            console.log("GAMES", games);
            model = games.first();
            console.log("MODEL", model);
          }
          _this.playerRegion(model);
          _this.userRegion(model);
          return _this.chatRegion(model);
        });
        return this.show(this.layout, {
          loading: {
            entities: entities
          }
        });
      };

      Controller.prototype.playerRegion = function(model) {
        var player;
        player = this.getPlayerView(model);
        return this.layout.playerRegion.show(player);
      };

      Controller.prototype.chatRegion = function(model) {
        var chat;
        chat = this.getChatView(model);
        return this.layout.chatRegion.show(chat);
      };

      Controller.prototype.userRegion = function(model) {
        var userView;
        userView = this.getUserView(model);
        return this.layout.userRegion.show(userView);
      };

      Controller.prototype.getPlayerView = function(model) {
        return new Views.Player({
          model: model
        });
      };

      Controller.prototype.getChatView = function(model) {
        return new Views.Chat({
          model: model
        });
      };

      Controller.prototype.getUserView = function(model) {
        return new Views.User({
          model: model
        });
      };

      Controller.prototype.getLayoutView = function() {
        return new Views.Layout;
      };

      return Controller;

    })(AppController);
  });

}).call(this);
