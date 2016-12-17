// Generated by CoffeeScript 1.12.2
(function() {
  define(["msgbus", "apps/streams/list/controller"], function(msgBus, Controller) {
    var API;
    API = {
      list: function(region, name) {
        return new Controller({
          region: region,
          name: name
        });
      }
    };
    return msgBus.commands.setHandler("app:stream:list", function(region, name) {
      return API.list(region, name);
    });
  });

}).call(this);
