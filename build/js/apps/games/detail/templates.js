(function() {
  define(function(require) {
    return {
      gamedetail: require("text!apps/games/detail/templates/gamedetail.htm"),
      layout: require("text!apps/games/detail/templates/layout.htm")
    };
  });

}).call(this);
