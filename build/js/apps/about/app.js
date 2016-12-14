(function() {
  var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  define(["msgbus", "marionette", "apps/about/show/controller"], function(msgBus, Marionette, Controller) {
    var API, Router, channel;
    channel = msgBus.appChannel;
    Router = (function(superClass) {
      extend(Router, superClass);

      function Router() {
        return Router.__super__.constructor.apply(this, arguments);
      }

      Router.prototype.appRoutes = {
        "about": "about"
      };

      return Router;

    })(Marionette.AppRouter);
    API = {
      about: function() {
        return new Controller;
      }
    };
    return channel.on("start:about:app", function() {
      return new Router({
        controller: API
      });
    });
  });

}).call(this);
