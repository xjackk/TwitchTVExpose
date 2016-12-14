(function() {
  define(["msgbus", "apps/streams/list/controller"], function(msgBus, Controller) {
    var API, channel;
    channel = msgBus.appChannel;
    API = {
      list: function(region, name) {
        return new Controller({
          region: region,
          name: name
        });
      }
    };
    return channel.on("app:stream:list", function(region, name) {
      return API.list(region, name);
    });
  });

}).call(this);
