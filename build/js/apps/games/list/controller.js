(function() {
  var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  define(["msgbus", "apps/games/list/views", "controller/_base", "backbone"], function(msgBus, Views, AppController, Backbone) {
    var Controller, channel;
    channel = msgBus.appChannel;
    return Controller = (function(superClass) {
      extend(Controller, superClass);

      function Controller() {
        return Controller.__super__.constructor.apply(this, arguments);
      }

      Controller.prototype.initialize = function(options) {
        if (options == null) {
          options = {};
        }
        this.entities = channel.request("games:top:entities");
        this.layout = this.getLayoutView();
        this.listenTo(this.layout, "show", (function(_this) {
          return function() {
            return _this.gameRegion();
          };
        })(this));
        this.listenTo(this.layout, "show:bubble", (function(_this) {
          return function() {
            return _this.gameBubbleRegion();
          };
        })(this));
        return this.show(this.layout, {
          loading: {
            entities: this.entities
          }
        });
      };

      Controller.prototype.gameRegion = function() {
        var view;
        view = this.getGameView(this.entities);
        this.listenTo(view, "childview:game:item:clicked", function(child, args) {
          return channel.trigger("app:game:detail", args.model);
        });
        this.listenTo(view, "scroll:more", function() {
          return channel.request("games:fetchmore");
        });
        return this.layout.gameRegion.show(view);
      };

      Controller.prototype.gameBubbleRegion = function() {
        var view;
        view = this.getBubbleView(this.entities);
        return this.layout.gameRegion.show(view);
      };

      Controller.prototype.getBubbleView = function(collection) {
        return new Views.GamesBubbleView({
          collection: collection
        });
      };

      Controller.prototype.getGameView = function(collection) {
        return new Views.TopGameList({
          collection: collection
        });
      };

      Controller.prototype.getLayoutView = function() {
        return new Views.Layout;
      };

      return Controller;

    })(AppController);
  });

}).call(this);
