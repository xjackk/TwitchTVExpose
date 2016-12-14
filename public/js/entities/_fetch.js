(function() {
  define(["msgbus"], function(msgBus) {
    var dataChannel;
    dataChannel = msgBus.dataChannel;
    return dataChannel.reply("when:fetched", function(entities, callback) {
      var xhrs;
      xhrs = _.chain([entities]).flatten().pluck("_fetch").value();
      return $.when.apply($, xhrs).done(function() {
        return callback();
      });
    });
  });

}).call(this);
