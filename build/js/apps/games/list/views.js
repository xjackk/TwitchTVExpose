(function() {
  var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty,
    bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  define(['apps/games/list/templates', 'views/_base', 'views/bubble'], function(Templates, AppView, BubbleChart) {
    var GameItem, GamesBubbleView, GamesLayout, TopGameList;
    GameItem = (function(superClass) {
      extend(GameItem, superClass);

      function GameItem() {
        return GameItem.__super__.constructor.apply(this, arguments);
      }

      GameItem.prototype.template = _.template(Templates.gameitem);

      GameItem.prototype.tagName = "li";

      GameItem.prototype.className = "col-md-2 col-sm-4 col-xs-12 game";

      GameItem.prototype.triggers = {
        "click": "game:item:clicked"
      };

      return GameItem;

    })(AppView.ItemView);
    return {
      TopGameList: TopGameList = (function(superClass) {
        extend(TopGameList, superClass);

        function TopGameList() {
          this.checkScroll = bind(this.checkScroll, this);
          return TopGameList.__super__.constructor.apply(this, arguments);
        }

        TopGameList.prototype.template = _.template(Templates.gameslist);

        TopGameList.prototype.itemView = GameItem;

        TopGameList.prototype.id = "gamelist";

        TopGameList.prototype.itemViewContainer = "#gameitems";

        TopGameList.prototype.events = {
          "scroll": "checkScroll"
        };

        TopGameList.prototype.checkScroll = function(e) {
          var margin, scrollTop, virtualHeight;
          virtualHeight = this.$("> div").height();
          scrollTop = this.$el.scrollTop() + this.$el.height();
          margin = 200;
          if ((scrollTop + margin) >= virtualHeight) {
            return this.trigger("scroll:more");
          }
        };

        return TopGameList;

      })(AppView.CompositeView),
      GamesBubbleView: GamesBubbleView = (function(superClass) {
        extend(GamesBubbleView, superClass);

        function GamesBubbleView() {
          return GamesBubbleView.__super__.constructor.apply(this, arguments);
        }

        GamesBubbleView.prototype.template = _.template(Templates.gamesbubble);

        GamesBubbleView.prototype.id = "gamesbubble";

        GamesBubbleView.prototype.onShow = function() {
          var $height, $width;
          $width = this.$el.outerWidth(false);
          $height = Math.floor($width * 9 / 16);
          this.chart = new BubbleChart(this.collection, this.el, $width, $height);
          this.chart.start();
          return this.chart.display();
        };

        return GamesBubbleView;

      })(AppView.ItemView),
      Layout: GamesLayout = (function(superClass) {
        extend(GamesLayout, superClass);

        function GamesLayout() {
          return GamesLayout.__super__.constructor.apply(this, arguments);
        }

        GamesLayout.prototype.template = _.template(Templates.layout);

        GamesLayout.prototype.regions = {
          gameRegion: "#game-region"
        };

        GamesLayout.prototype.events = {
          "click .bubble": "bubble",
          "click .grid": "grid"
        };

        GamesLayout.prototype.bubble = function() {
          return this.trigger("show:bubble");
        };

        GamesLayout.prototype.grid = function() {
          return this.trigger("show");
        };

        return GamesLayout;

      })(AppView.Layout)
    };
  });

}).call(this);
