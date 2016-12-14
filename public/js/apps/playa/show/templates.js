(function() {
  define(function(require) {
    return {
      player: require("text!apps/playa/show/templates/playerhtml5.htm"),
      user: require("text!apps/playa/show/templates/user.htm"),
      layout: require("text!apps/playa/show/templates/layout.htm"),
      chat: require("text!apps/playa/show/templates/chat.htm")
    };
  });

}).call(this);
