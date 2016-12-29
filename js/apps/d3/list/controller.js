// Generated by CoffeeScript 1.12.2
(function() {
  var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  define(["msgbus", "apps/d3/list/views", "marionette"], function(MsgBus, Views, Mn) {
    var Controller, appChannel;
    appChannel = MsgBus.appChannel;
    return Controller = (function(superClass) {
      extend(Controller, superClass);

      function Controller() {
        return Controller.__super__.constructor.apply(this, arguments);
      }

      Controller.prototype.initialize = function(options) {
        var layout, region;
        region = appChannel.request("default:region");
        layout = new Views.Layout;
        return region.show(layout);
      };

      return Controller;

    })(Mn.Object);
  });

}).call(this);
