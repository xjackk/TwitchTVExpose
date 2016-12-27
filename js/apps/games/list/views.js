// Generated by CoffeeScript 1.12.2
(function() {
  var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty,
    bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  define(['apps/games/list/templates', 'marionette', 'views/bubble'], function(Templates, Mn, BubbleChart) {
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

    })(Mn.View);
    return {
      TopGameList: TopGameList = (function(superClass) {
        extend(TopGameList, superClass);

        function TopGameList() {
          this.checkScroll = bind(this.checkScroll, this);
          return TopGameList.__super__.constructor.apply(this, arguments);
        }

        TopGameList.prototype.childView = GameItem;

        TopGameList.prototype.tagName = "ul";

        TopGameList.prototype.className = "list-inline";

        TopGameList.prototype.events = {
          "scroll": "checkScroll"
        };

        TopGameList.prototype.checkScroll = function(e) {
          var margin, scrollTop, virtualHeight;
          console.log(e);
          virtualHeight = this.$("> div").height();
          console.log(virtualHeight);
          scrollTop = this.$el.scrollTop() + this.$el.height();
          margin = 200;
          if ((scrollTop + margin) >= virtualHeight) {
            return this.trigger("scroll:more");
          }
        };

        return TopGameList;

      })(Mn.CollectionView),
      GamesBubbleView: GamesBubbleView = (function(superClass) {
        extend(GamesBubbleView, superClass);

        function GamesBubbleView() {
          return GamesBubbleView.__super__.constructor.apply(this, arguments);
        }

        GamesBubbleView.prototype.template = _.template(Templates.gamesbubble);

        GamesBubbleView.prototype.id = "gamesbubble";

        GamesBubbleView.prototype.onDomRefresh = function() {
          var $height, $width;
          $width = this.$el.outerWidth(true);
          $height = Math.floor($width * 10 / 16);
          this.chart = new BubbleChart(this.collection, this.el, $width, $height);
          this.chart.start();
          return this.chart.display();
        };

        return GamesBubbleView;

      })(Mn.View),
      Layout: GamesLayout = (function(superClass) {
        extend(GamesLayout, superClass);

        function GamesLayout() {
          return GamesLayout.__super__.constructor.apply(this, arguments);
        }

        GamesLayout.prototype.template = _.template(Templates.layout);

        GamesLayout.prototype.regions = {
          topGameList: {
            el: "ul",
            replaceElement: true
          }
        };

        GamesLayout.prototype.ui = {
          btnBubble: "button.bubble",
          btnGrid: "button.grid"
        };

        GamesLayout.prototype.triggers = {
          "click @ui.btnBubble": "show:bubble",
          "click @ui.btnGrid": "show:grid"
        };

        GamesLayout.prototype.onRender = function() {
          return this.showChildView("topGameList", new TopGameList({
            collection: this.collection
          }));
        };

        return GamesLayout;

      })(Mn.View)
    };
  });

}).call(this);
