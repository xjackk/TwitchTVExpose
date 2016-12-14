(function() {
  var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  define(["marionette", "msgbus", "apps/d3/list/controller"], function(Marionette, msgBus, Controller) {
    var API, Router, channel;
    channel = msgBus.appChannel;
    Router = (function(superClass) {
      extend(Router, superClass);

      function Router() {
        return Router.__super__.constructor.apply(this, arguments);
      }

      Router.prototype.appRoutes = {
        "d3": "tedifyouseethisyousmell"
      };

      return Router;

    })(Marionette.AppRouter);
    API = {
      tedifyouseethisyousmell: function() {
        return new Controller;
      }
    };
    return channel.on("start:d3:app", function() {
      return new Router({
        controller: API
      });
    });
  });

}).call(this);
