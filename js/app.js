// Generated by CoffeeScript 1.12.1
(function() {
  define(["backbone", "marionette", "msgbus", "entities/appstate", "apps/load"], function(Backbone, Marionette, msgBus, AppState) {
    var app;
    app = new Backbone.Marionette.Application();
    app.rootRoute = "about";
    app.authRoute = "games";
    app.addRegions({
      headerRegion: "#header-region",
      mainRegion: "  #main-region",
      footerRegion: "#footer-region"
    });
    app.on("initialize:before", function(options) {
      if (options == null) {
        options = {};
      }
    });
    msgBus.reqres.setHandler("default:region", function() {
      return app.mainRegion;
    });
    msgBus.reqres.setHandler("header:region", function() {
      return app.headerRegion;
    });
    msgBus.reqres.setHandler("footer:region", function() {
      return app.footerRegion;
    });
    msgBus.reqres.setHandler("main:region", function() {
      return app.mainRegion;
    });
    msgBus.commands.setHandler("register:instance", function(instance, id) {
      return app.register(instance, id);
    });
    msgBus.commands.setHandler("unregister:instance", function(instance, id) {
      return app.unregister(instance, id);
    });
    app.on("start", function(options) {
      var frag, match;
      if (options == null) {
        options = {};
      }
      if (Backbone.history) {
        Backbone.history.start();
        frag = Backbone.history.fragment;
        match = /access_token/i.test(frag);
        if (match) {
          AppState.set("accessToken", frag.split(/[=&]/)[1]);
          AppState.set("loginStatus", true);
          return this.navigate(this.authRoute, {
            trigger: true
          });
        } else {
          AppState.set("loginStatus", false);
          if (this.getCurrentRoute() === null) {
            return this.navigate(this.rootRoute, {
              trigger: true
            });
          }
        }
      }
    });
    app.addInitializer(function(options) {
      msgBus.commands.execute("start:header:app");
      msgBus.commands.execute("start:footer:app");
      msgBus.commands.execute("start:d3:app");
      msgBus.commands.execute("start:about:app");
      msgBus.commands.execute("start:games:app");
      return msgBus.commands.execute("start:playa:app");
    });
    return app;
  });

}).call(this);
