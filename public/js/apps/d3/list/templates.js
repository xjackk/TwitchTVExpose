(function() {
  define(function(require) {
    return {
      datavis: require("text!apps/d3/list/templates/datavis.htm"),
      layout: require("text!apps/d3/list/templates/layout.htm")
    };
  });

}).call(this);
