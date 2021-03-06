// Generated by CoffeeScript 1.12.2
(function() {
  var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  define(["msgbus", "apps/header/list/views", "controller/_base", "entities/header"], function(msgBus, Views, AppController) {
    var Controller;
    return Controller = (function(superClass) {
      extend(Controller, superClass);

      function Controller() {
        return Controller.__super__.constructor.apply(this, arguments);
      }

      Controller.prototype.initialize = function() {
        var links;
        links = msgBus.reqres.request("header:entities");
        this.appstate = msgBus.reqres.request("get:current:appstate");
        this.layout = this.getLayoutView();
        this.listenTo(this.appstate, "change:loginStatus", (function(_this) {
          return function(model, status) {
            if (status === true) {
              _this.loginView.close();
            }
            if (status === false) {
              return _this.loginView.render();
            }
          };
        })(this));
        this.listenTo(this.layout, "show", (function(_this) {
          return function() {
            _this.listRegion(links);
            _this.loginView = _this.getLoginView(_this.appstate);
            return _this.loginView.render();
          };
        })(this));
        return this.show(this.layout);
      };

      Controller.prototype.getHeaderView = function(links) {
        return new Views.HeaderView({
          collection: links
        });
      };

      Controller.prototype.getLoginView = function(model) {
        return new Views.LoginView({
          model: model
        });
      };

      Controller.prototype.getLayoutView = function() {
        return new Views.Layout;
      };

      Controller.prototype.listRegion = function(links) {
        var view;
        view = this.getHeaderView(links);
        return this.layout.listRegion.show(view);
      };

      return Controller;

    })(AppController);
  });

}).call(this);
