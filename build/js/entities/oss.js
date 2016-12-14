(function() {
  define(["backbone", "msgbus"], function(Backbone, msgBus) {
    var API, dataChannel;
    dataChannel = msgBus.dataChannel;
    API = {
      getOSS: function() {
        return new Backbone.Collection([
          {
            name: "Github",
            site: "https://github.com",
            image: "https://github.global.ssl.fastly.net/images/modules/dashboard/bootcamp/octocat_fork.png?74c9d5ac",
            ghurl: "https://github.com"
          }, {
            name: "Backbone",
            site: "http://backbonejs.org",
            image: "http://backbonejs.org/docs/images/backbone.png",
            ghurl: "https://github.com/jashkenas/backbone/"
          }, {
            name: "Marionette",
            site: "http://marionettejs.com/",
            image: "http://marionettejs.com/images/logo-a4052db8.png",
            ghurl: "https://github.com/marionettejs/backbone.marionette"
          }, {
            name: "RequireJS",
            site: "http://requirejs.org",
            image: "http://requirejs.org/i/logo.png",
            ghurl: "https://github.com/jrburke/requirejs"
          }, {
            name: "Underscore",
            site: "http://backbonejs.org",
            image: "http://underscorejs.org/docs/images/underscore.png",
            ghurl: "https://github.com/jashkenas/underscore"
          }, {
            name: "Bootstrap",
            site: "http://getBootstrap.com",
            image: "image/bootstrap.png",
            ghurl: "https://github.com/twbs/bootstrap"
          }, {
            name: "D3",
            site: "http://d3js.org",
            image: "http://d3js.org/ex/cloud.png",
            ghurl: "https://github.com/mbostock/d3"
          }, {
            name: "JQuery",
            site: "http://jquery.com",
            image: "http://jquery.com/jquery-wp-content/themes/jquery/images/logo-jquery.png",
            ghurl: "https://github.com/jquery/jquery"
          }
        ]);
      }
    };
    return dataChannel.reply("oss:entities", function() {
      return API.getOSS();
    });
  });

}).call(this);
