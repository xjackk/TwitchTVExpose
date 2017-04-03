// Generated by CoffeeScript 1.12.2
(function() {
  var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  define(["msgbus", "apps/games/detail/views", "controller/_base", "backbone"], function(msgBus, Views, AppController, Backbone) {
    var Controller;
    return Controller = (function(superClass) {
      extend(Controller, superClass);

      function Controller() {
        return Controller.__super__.constructor.apply(this, arguments);
      }

      Controller.prototype.initialize = function(options) {
        var gameModel, gameName;
        gameName = options.gameName, gameModel = options.gameModel;
        if (gameModel === void 0) {
          gameModel = msgBus.reqres.request("games:searchName", gameName);
        }
        this.layout = this.getLayoutView();
        this.listenTo(this.layout, "show", (function(_this) {
          return function() {
            return _this.gameRegion(gameModel);
          };
        })(this));
        return this.show(this.layout, {
          loading: {
            entities: gameModel
          }
        });
      };

      Controller.prototype.gameRegion = function(model) {
        var view;
        view = this.getGameView(model);
        msgBus.commands.execute("app:stream:list", this.layout.streamRegion, model.get("game").name);
        return this.layout.gameRegion.show(view);
      };

      Controller.prototype.getGameView = function(model) {
        return new Views.Detail({
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
