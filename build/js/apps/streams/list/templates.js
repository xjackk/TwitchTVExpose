(function() {
  define(function(require) {
    return {
      streams: require("text!apps/streams/list/templates/streams.htm"),
      streamitem: require("text!apps/streams/list/templates/streamitem.htm")
    };
  });

}).call(this);
