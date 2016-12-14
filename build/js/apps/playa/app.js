(function() {
  var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  define(["msgbus", "backbone", "marionette", "apps/playa/show/controller"], function(msgBus, Backbone, Marionette, Controller) {
    var API, Router, channel;
    channel = msgBus.appChannel;
    Router = (function(superClass) {
      extend(Router, superClass);

      function Router() {
        return Router.__super__.constructor.apply(this, arguments);
      }

      Router.prototype.appRoutes = {
        "player/:game/:channel": "show"
      };

      return Router;

    })(Marionette.AppRouter);
    API = {
      show: function(game, channel, model) {
        return new Controller({
          channel: channel,
          model: model
        });
      }
    };
    channel.on("start:playa:app", function() {
      return new Router({
        controller: API
      });
    });
    return channel.on("app:playa:show", function(streamModel) {
      Backbone.history.navigate("player/" + (streamModel.get("game")) + "/" + (streamModel.get("channel").display_name), {
        trigger: false
      });
      return API.show(streamModel.get("game"), streamModel.get("channel").display_name, streamModel);
    });
  });

}).call(this);
