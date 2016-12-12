// Generated by CoffeeScript 1.9.2
(function() {
  var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  define(["msgbus", "marionette", "backbone", "apps/games/list/controller", "apps/games/detail/controller", "entities/appstate"], function(msgBus, Marionette, Backbone, ListController, DetailController, AppState) {
    var API, Router, channel;
    channel = msgBus.appChannel;
    Router = (function(superClass) {
      extend(Router, superClass);

      function Router() {
        return Router.__super__.constructor.apply(this, arguments);
      }

      Router.prototype.appRoutes = {
        "games": "list",
        "games/:id/detail": "detail"
      };

      return Router;

    })(Marionette.AppRouter);
    API = {
      list: function() {
        if (AppState.get("loginStatus") !== true) {
          return Backbone.history.navigate("#d3", {
            trigger: true
          });
        }
        return new ListController;
      },
      detail: function(id, model) {
        return new DetailController({
          gameName: id,
          gameModel: model
        });
      }
    };
    channel.on("app:game:detail", function(model) {
      Backbone.history.navigate("games/" + (model.get("game").name) + "/detail", {
        trigger: false
      });
      return API.detail(model.get("game").name, model);
    });
    return channel.on("start:games:app", function() {
      return new Router({
        controller: API
      });
    });
  });

}).call(this);
