(function() {
  var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  define(["apps/d3/list/views", "controller/_base"], function(Views, AppController) {
    var Controller;
    return Controller = (function(superClass) {
      extend(Controller, superClass);

      function Controller() {
        return Controller.__super__.constructor.apply(this, arguments);
      }

      Controller.prototype.initialize = function(options) {
        this.layout = this.getLayoutView();
        this.listenTo(this.layout, "show", (function(_this) {
          return function() {
            return _this.visRegion();
          };
        })(this));
        return this.show(this.layout);
      };

      Controller.prototype.visRegion = function() {
        var view;
        view = this.getDataVisView();
        return this.layout.dataVisRegion1.show(view);
      };

      Controller.prototype.getDataVisView = function() {
        return new Views.DataVis;
      };

      Controller.prototype.getLayoutView = function() {
        return new Views.Layout;
      };

      return Controller;

    })(AppController);
  });

}).call(this);
