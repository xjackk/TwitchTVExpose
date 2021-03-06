// Generated by CoffeeScript 1.12.2
(function() {
  var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  define(["msgbus", "apps/about/show/views", "controller/_base"], function(msgBus, Views, AppController) {
    var Controller;
    return Controller = (function(superClass) {
      extend(Controller, superClass);

      function Controller() {
        return Controller.__super__.constructor.apply(this, arguments);
      }

      Controller.prototype.initialize = function(options) {
        var entities, ossentities;
        entities = msgBus.reqres.request("reference:entities");
        ossentities = msgBus.reqres.request("oss:entities");
        this.layout = this.getLayoutView();
        this.listenTo(this.layout, "show", (function(_this) {
          return function() {
            _this.aboutRegion();
            _this.bookRegion(entities);
            return _this.ossRegion(ossentities);
          };
        })(this));
        return this.show(this.layout, {
          loading: {
            entities: entities
          }
        });
      };

      Controller.prototype.aboutRegion = function() {
        var view;
        view = this.getAboutView();
        return this.layout.aboutRegion.show(view);
      };

      Controller.prototype.bookRegion = function(collection) {
        var view;
        view = this.getBookView(collection);
        return this.layout.bookRegion.show(view);
      };

      Controller.prototype.ossRegion = function(collection) {
        var view;
        view = this.getOssView(collection);
        return this.layout.ossRegion.show(view);
      };

      Controller.prototype.getOssView = function(collection) {
        return new Views.Oss({
          collection: collection
        });
      };

      Controller.prototype.getBookView = function(collection) {
        return new Views.Books({
          collection: collection
        });
      };

      Controller.prototype.getAboutView = function() {
        return new Views.About;
      };

      Controller.prototype.getLayoutView = function() {
        return new Views.Layout;
      };

      return Controller;

    })(AppController);
  });

}).call(this);
