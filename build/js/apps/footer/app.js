(function() {
  define(["msgbus", "apps/footer/show/controller"], function(msgBus, Controller) {
    var API, channel;
    channel = msgBus.appChannel;
    API = {
      show: function() {
        return new Controller({
          region: channel.request("footer:region")
        });
      }
    };
    return channel.on("start:footer:app", function() {
      return API.show();
    });
  });

}).call(this);
