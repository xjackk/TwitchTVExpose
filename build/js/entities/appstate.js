(function() {
  var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  define(["backbone"], function(Backbone) {
    var API, AppState, appState;
    AppState = (function(superClass) {
      extend(AppState, superClass);

      function AppState() {
        return AppState.__super__.constructor.apply(this, arguments);
      }

      AppState.prototype.defaults = {
        clientId: "x77jaxed6gmro98hgmv3poxrzf9dty",
        accessToken: "n/a",
        loginStatus: false,
        uri: "http://localhost:3000"
      };

      return AppState;

    })(Backbone.Model);
    API = {
      getAppState: function() {
        return appState;
      }
    };
    return appState = new AppState;
  });

}).call(this);
