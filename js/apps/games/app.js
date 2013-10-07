// Generated by CoffeeScript 1.6.3
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(["msgbus", "marionette", "backbone", "apps/games/list/controller", "apps/games/detail/controller"], function(msgBus, Marionette, Backbone, ListController, DetailController) {
    var API, Router, _ref;
    Router = (function(_super) {
      __extends(Router, _super);

      function Router() {
        _ref = Router.__super__.constructor.apply(this, arguments);
        return _ref;
      }

      Router.prototype.appRoutes = {
        "games": "list",
        "games/:id/detail": "detail"
      };

      return Router;

    })(Marionette.AppRouter);
    API = {
      list: function() {
        return new ListController;
      },
      detail: function(id, model) {
        return new DetailController({
          gameName: id,
          gameModel: model
        });
      }
    };
    msgBus.events.on("app:game:detail", function(model) {
      Backbone.history.navigate("games/" + (model.get("game").name) + "/detail", {
        trigger: false
      });
      console.log("APP:GAMES:LIST=> (from list controller) MODEL", model);
      return API.detail(model.get("game").name, model);
    });
    return msgBus.commands.setHandler("start:games:app", function() {
      return new Router({
        controller: API
      });
    });
  });

}).call(this);