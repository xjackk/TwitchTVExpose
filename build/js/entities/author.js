(function() {
  var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  define(["backbone", "msgbus"], function(Backbone, msgBus) {
    var API, Author, dataChannel;
    dataChannel = msgBus.dataChannel;
    Author = (function(superClass) {
      extend(Author, superClass);

      function Author() {
        return Author.__super__.constructor.apply(this, arguments);
      }

      Author.prototype.defaults = {
        fullName: "Jack Killilea",
        twitter: "https://www.twitter.com/jack_killilea",
        github: "https://www.github.com/xjackk"
      };

      return Author;

    })(Backbone.Model);
    API = {
      getAuthor: function() {
        return new Author;
      }
    };
    return dataChannel.reply("get:authorModel:info", function() {
      return API.getAuthor();
    });
  });

}).call(this);
