(function() {
  define(["backbone", "backbone.radio"], function(Backbone) {
    return {
      appChannel: Backbone.Radio.channel('app'),
      dataChannel: Backbone.Radio.channel('data'),
      componentChannel: Backbone.Radio.channel('component')
    };
  });

}).call(this);
