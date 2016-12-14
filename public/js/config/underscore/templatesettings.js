(function() {
  define(['underscore'], function(_) {
    return _.templateSettings = {
      evaluate: /\{\[([\s\S]+?)\]\}/g,
      interpolate: /\{\{(.+?)\}\}/g
    };
  });

}).call(this);
