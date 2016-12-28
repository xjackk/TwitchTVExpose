// Generated by CoffeeScript 1.12.2
(function() {
  var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  define(["msgbus", "apps/games/detail/views", "controller/_base"], function(msgBus, Views, AppController) {
    var Controller, appChannel;
    appChannel = msgBus.appChannel;
    return Controller = (function(superClass) {
      extend(Controller, superClass);

      function Controller() {
        return Controller.__super__.constructor.apply(this, arguments);
      }

      Controller.prototype.initialize = function(options) {
        var gameModel, gameName;
        gameName = options.gameName, gameModel = options.gameModel;
        console.log(options);
        if (gameModel === void 0) {
          gameModel = appChannel.request("games:searchName", gameName);
        }
        this.layout = this.getLayoutView({
          gameModel: gameModel
        });
        this.listenTo(this.layout, "show", (function(_this) {
          return function() {
            return _this.showStreams(gameModel);
          };
        })(this));
        return this.show(this.layout, {
          loading: {
            entities: gameModel
          }
        });
      };

      Controller.prototype.showStreams = function(model) {
        return appChannel.trigger("app:streams:list", this.layout.getRegion('streamRegion'), model.get("game").name);
      };

      Controller.prototype.getLayoutView = function(options) {
        return new Views.Layout(options);
      };

      return Controller;

    })(AppController);
  });

}).call(this);
