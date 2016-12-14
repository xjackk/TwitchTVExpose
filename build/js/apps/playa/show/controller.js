(function() {
  var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  define(["apps/playa/show/views", "controller/_base", "msgbus"], function(Views, AppController, msgBus) {
    var Controller, channel;
    channel = msgBus.appChannel;
    return Controller = (function(superClass) {
      extend(Controller, superClass);

      function Controller() {
        return Controller.__super__.constructor.apply(this, arguments);
      }

      Controller.prototype.initialize = function(options) {
        var model;
        if (options == null) {
          options = {};
        }
        channel = options.channel, model = options.model;
        if (model === void 0) {
          model = channel.request("search:stream:model", channel);
        }
        this.layout = this.getLayoutView();
        this.listenTo(this.layout, "show", (function(_this) {
          return function() {
            _this.playerRegion(model);
            _this.userRegion(model);
            return _this.chatRegion(model);
          };
        })(this));
        return this.show(this.layout, {
          loading: {
            entities: model
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
