(function() {
  define(["backbone", "marionette"], function(Backbone, Marionette) {
    return _.extend(Marionette.Application.prototype, {
      navigate: function(route, options) {
        if (options == null) {
          options = {};
        }
        if (route.charAt(0) === "/") {
          route = "#" + route;
        }
        return Backbone.history.navigate(route, options);
      },
      getCurrentRoute: function() {
        var frag;
        frag = Backbone.history.fragment;
        if (_.isEmpty(frag)) {
          return null;
        } else {
          return frag;
        }
      },
      startHistory: function() {
        if (Backbone.history) {
          return Backbone.history.start();
        }
      },
      register: function(instance, id) {
        if (this._registry == null) {
          this._registry = {};
        }
        return this._registry[id] = instance;
      },
      unregister: function(instance, id) {
        return delete this._registry[id];
      },
      resetRegistry: function() {
        var controller, key, msg, oldCount, ref;
        oldCount = this.getRegistrySize();
        ref = this._registry;
        for (key in ref) {
          controller = ref[key];
          controller.region.close();
        }
        msg = "There were " + oldCount + " controllers in the registry, there are now " + (this.getRegistrySize());
        if (this.getRegistrySize() > 0) {
          return console.warn(msg, this._registry);
        } else {
          return console.log(msg);
        }
      },
      getRegistrySize: function() {
        return _.size(this._registry);
      }
    });
  });

}).call(this);
