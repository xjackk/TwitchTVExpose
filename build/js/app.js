(function() {
  define(["backbone", "marionette", "msgbus", "entities/appstate", "apps/load"], function(Backbone, Marionette, msgBus, AppState) {
    var app, appChannel;
    appChannel = msgBus.appChannel;
    app = new Backbone.Marionette.Application();
    app.rootRoute = "about";
    app.authRoute = "games";
    app.addRegions({
      headerRegion: "#header-region",
      mainRegion: "  #main-region",
      footerRegion: "#footer-region"
    });
    appChannel.reply("default:region", function() {
      return app.mainRegion;
    });
    appChannel.reply("header:region", function() {
      return app.headerRegion;
    });
    appChannel.reply("footer:region", function() {
      return app.footerRegion;
    });
    appChannel.reply("main:region", function() {
      return app.mainRegion;
    });
    appChannel.reply("register:instance", function(instance, id) {
      return app.register(instance, id);
    });
    appChannel.reply("unregister:instance", function(instance, id) {
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
      appChannel.trigger("start:header:app");
      appChannel.trigger("start:footer:app");
      appChannel.trigger("start:d3:app");
      appChannel.trigger("start:about:app");
      appChannel.trigger("start:games:app");
      return appChannel.trigger("start:playa:app");
    });
    return app;
  });

}).call(this);
