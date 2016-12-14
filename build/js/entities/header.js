(function() {
  define(["backbone", "msgbus"], function(Backbone, msgBus) {
    var API, dataChannel;
    dataChannel = msgBus.dataChannel;
    API = {
      getHeaders: function() {
        return new Backbone.Collection([
          {
            name: "Games",
            url: "#games",
            title: "Live Games",
            cssClass: "glyphicon glyphicon-hdd"
          }, {
            name: "D3",
            url: "#d3",
            title: "Sample D3 visualization",
            cssClass: "glyphicon glyphicon-list"
          }, {
            name: "About",
            url: "#about",
            title: "Learn about responsive Twitch-TV",
            cssClass: "glyphicon glyphicon-align-justify"
          }
        ]);
      }
    };
    return dataChannel.reply("header:entities", function() {
      return API.getHeaders();
    });
  });

}).call(this);
