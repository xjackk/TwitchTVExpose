(function() {
  var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  define(["msgbus", "apps/footer/show/views", "controller/_base"], function(msgBus, View, AppController) {
    var Controller, channel;
    channel = msgBus.appChannel;
    return Controller = (function(superClass) {
      extend(Controller, superClass);

      function Controller() {
        return Controller.__super__.constructor.apply(this, arguments);
      }

      Controller.prototype.initialize = function() {
        var author, footerView;
        author = channel.request("get:authorModel:info");
        footerView = this.getFooterView(author);
        return this.show(footerView);
      };

      Controller.prototype.getFooterView = function(model) {
        return new View.ItemView({
          model: model
        });
      };

      return Controller;

    })(AppController);
  });

}).call(this);
