// Generated by CoffeeScript 1.12.2
(function() {
  var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  define(["apps/playa/show/views", "marionette", "msgbus"], function(Views, Mn, msgBus) {
    var Controller, appChannel;
    appChannel = msgBus.appChannel;
    return Controller = (function(superClass) {
      extend(Controller, superClass);

      function Controller() {
        return Controller.__super__.constructor.apply(this, arguments);
      }

      Controller.prototype.initialize = function(options) {
        var channel, mainRegion, model;
        if (options == null) {
          options = {};
        }
        channel = options.channel, model = options.model;
        mainRegion = appChannel.request("default:region");
        if (model === void 0) {
          model = appChannel.request("search:stream:model", channel);
        }
        return appChannel.trigger("when:fetched", model, (function(_this) {
          return function() {
            var layout;
            layout = _this.getLayoutView(model);
            return mainRegion.show(layout);
          };
        })(this));
      };

      Controller.prototype.getLayoutView = function(model) {
        return new Views.Layout({
          model: model
        });
      };

      return Controller;

    })(Mn.Object);
  });

}).call(this);
