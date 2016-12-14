(function() {
  var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  define(['apps/games/detail/templates', 'views/_base'], function(Templates, AppView) {
    var GameDetail, GamesLayout;
    return {
      Detail: GameDetail = (function(superClass) {
        extend(GameDetail, superClass);

        function GameDetail() {
          return GameDetail.__super__.constructor.apply(this, arguments);
        }

        GameDetail.prototype.template = _.template(Templates.gamedetail);

        GameDetail.prototype.className = "col-xs-12";

        return GameDetail;

      })(AppView.ItemView),
      Layout: GamesLayout = (function(superClass) {
        extend(GamesLayout, superClass);

        function GamesLayout() {
          return GamesLayout.__super__.constructor.apply(this, arguments);
        }

        GamesLayout.prototype.template = _.template(Templates.layout);

        GamesLayout.prototype.regions = {
          gameRegion: "#game-region",
          streamRegion: "#stream-region"
        };

        return GamesLayout;

      })(AppView.Layout)
    };
  });

}).call(this);
