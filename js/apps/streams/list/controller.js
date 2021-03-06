// Generated by CoffeeScript 1.12.2
(function() {
  var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  define(["msgbus", "apps/streams/list/views", "controller/_base", "entities/appstate"], function(msgBus, Views, AppController, AppState) {
    var Controller;
    return Controller = (function(superClass) {
      extend(Controller, superClass);

      function Controller() {
        return Controller.__super__.constructor.apply(this, arguments);
      }

      Controller.prototype.initialize = function(options) {
        var name, streamEntities, view;
        if (options == null) {
          options = {};
        }
        name = options.name;
        console.log("streams:list:controller OPTIONS", options);
        streamEntities = msgBus.reqres.request("search:stream:entities", name);
        view = this.getListView(streamEntities);
        this.listenTo(view, "childview:stream:item:clicked", function(child, args) {
          return msgBus.events.trigger("app:playa:show", args.model);
        });
        this.listenTo(view, "scroll:more", function() {
          return msgBus.reqres.request("streams:fetchmore");
        });
        return this.show(view, {
          loading: true
        });
      };

      Controller.prototype.getListView = function(collection) {
        return new Views.ListView({
          collection: collection
        });
      };

      return Controller;

    })(AppController);
  });

}).call(this);
