(function() {
  define(["msgbus", "apps/header/list/controller"], function(msgBus, Controller) {
    var API, channel;
    channel = msgBus.appChannel;
    API = {
      list: function() {
        return new Controller({
          region: channel.request("header:region")
        });
      }
    };
    return channel.on("start:header:app", function() {
      return API.list();
    });
  });

}).call(this);
