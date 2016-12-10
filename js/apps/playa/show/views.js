// Generated by CoffeeScript 1.12.1
(function() {
  var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  define(['apps/playa/show/templates', 'views/_base', 'swf'], function(Templates, AppView, swf) {
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

        Player.prototype.onShow = function() {
          var $height, $width, flashvars, params;
          $width = this.ui.panelbody.outerWidth(false);
          $height = Math.floor($width * 9 / 16);
          flashvars = false;
          params = {
            allowFullScreen: "true",
            wmode: "transparent",
            allowScriptAccess: "always",
            allowNetworking: "all",
            flashvars: "hostname=www.twitch.tv&channel=" + (this.model.get("channel").display_name) + "&start_volume=15&auto_play=true&client_id=hqxyqc9bf41e6grm6txrsdcwncoxavz&res=720p"
          };
          return swf.embedSWF("https://www-cdn.jtvnw.net/widgets/live_embed_player.swf?channel=" + (this.model.get("channel").display_name) + "&auto_play=true", "twitchplayer", $width, $height, "9", null, flashvars, params, {});
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
