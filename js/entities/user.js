// Generated by CoffeeScript 1.12.2
(function() {
  var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  define(["entities/_backbone", "msgbus"], function(_Backbone, msgBus) {
    var API, User, UsersCollection;
    User = (function(superClass) {
      extend(User, superClass);

      function User() {
        return User.__super__.constructor.apply(this, arguments);
      }

      return User;

    })(_Backbone.Model);
    UsersCollection = (function(superClass) {
      extend(UsersCollection, superClass);

      function UsersCollection() {
        return UsersCollection.__super__.constructor.apply(this, arguments);
      }

      UsersCollection.prototype.model = User;

      return UsersCollection;

    })(_Backbone.Collection);
    API = {
      setCurrentUser: function(currentUser) {
        return new User(currentUser);
      }
    };
    return msgBus.reqres.setHandler("set:current:user", function(currentUser) {
      return API.setCurrentUser(currentUser);
    });
  });

}).call(this);
