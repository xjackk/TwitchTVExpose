(function() {
  var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty,
    slice = [].slice;

  define(["marionette", "msgbus"], function(Marionette, msgBus) {
    var AppController, channel, componentChannel;
    channel = msgBus.appChannel;
    componentChannel = msgBus.componentChannel;
    return AppController = (function(superClass) {
      extend(AppController, superClass);

      function AppController(options) {
        if (options == null) {
          options = {};
        }
        this.region = options.region || channel.request("default:region");
        this._instance_id = _.uniqueId("controller");
        channel.trigger("register:instance", this, this._instance_id);
        AppController.__super__.constructor.call(this, options);
      }

      AppController.prototype.close = function() {
        var args;
        args = 1 <= arguments.length ? slice.call(arguments, 0) : [];
        delete this.region;
        delete this.options;
        channel.trigger("unregister:instance", this, this._instance_id);
        return AppController.__super__.close.call(this, args);
      };

      AppController.prototype.show = function(view, options) {
        if (options == null) {
          options = {};
        }
        _.defaults(options, {
          loading: false,
          region: this.region
        });
        this._setMainView(view);
        return this._manageView(view, options);
      };

      AppController.prototype._setMainView = function(view) {
        if (this._mainView) {
          return;
        }
        this._mainView = view;
        return this.listenTo(view, "close", this.close);
      };

      AppController.prototype._manageView = function(view, options) {
        if (options.loading) {
          return componentChannel.request("show:loading", view, options);
        } else {
          return options.region.show(view);
        }
      };

      return AppController;

    })(Marionette.Controller);
  });

}).call(this);
