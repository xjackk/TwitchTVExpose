(function() {
  var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  define(['apps/playa/show/templates', 'views/_base'], function(Templates, AppView) {
    var Chat, Layout, Player, User;
    return {
      Player: Player = (function(superClass) {
        extend(Player, superClass);

        function Player() {
          return Player.__super__.constructor.apply(this, arguments);
        }

        Player.prototype.template = _.template(Templates.player);

        Player.prototype.ui = {
          panelbody: ".panel-body"
        };

        Player.prototype.modelEvents = {
          "change:video_height": "render"
        };

        Player.prototype.onShow = function() {
          var ph, pw;
          pw = this.ui.panelbody.outerWidth(false);
          ph = Math.floor((pw - 30) * 9 / 16);
          console.log("Video Height: " + (this.model.get('video_height')));
          this.model.set("video_height", ph);
          console.log("Video Height: AFTER RESIZE: " + (this.model.get('video_height')));
          return console.log("Panel Width (var): " + pw);
        };

        return Player;

      })(AppView.ItemView),
      User: User = (function(superClass) {
        extend(User, superClass);

        function User() {
          return User.__super__.constructor.apply(this, arguments);
        }

        User.prototype.template = _.template(Templates.user);

        return User;

      })(AppView.ItemView),
      Chat: Chat = (function(superClass) {
        extend(Chat, superClass);

        function Chat() {
          return Chat.__super__.constructor.apply(this, arguments);
        }

        Chat.prototype.template = _.template(Templates.chat);

        return Chat;

      })(AppView.ItemView),
      Layout: Layout = (function(superClass) {
        extend(Layout, superClass);

        function Layout() {
          return Layout.__super__.constructor.apply(this, arguments);
        }

        Layout.prototype.template = _.template(Templates.layout);

        Layout.prototype.regions = {
          playerRegion: "#player-region",
          userRegion: "#user-region",
          chatRegion: "#chat-region"
        };

        return Layout;

      })(AppView.Layout)
    };
  });

}).call(this);
