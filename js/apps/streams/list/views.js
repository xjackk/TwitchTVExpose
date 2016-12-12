// Generated by CoffeeScript 1.9.2
(function() {
  var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty,
    bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  define(['views/_base', 'apps/streams/list/templates'], function(AppViews, Templates) {
    var StreamItem, StreamList;
    StreamItem = (function(superClass) {
      extend(StreamItem, superClass);

      function StreamItem() {
        return StreamItem.__super__.constructor.apply(this, arguments);
      }

      StreamItem.prototype.template = _.template(Templates.streamitem);

      StreamItem.prototype.tagName = "li";

      StreamItem.prototype.className = "col-md-6 col-xs-12 streamitem";

      StreamItem.prototype.triggers = {
        "click": "stream:item:clicked"
      };

      return StreamItem;

    })(AppViews.ItemView);
    return {
      ListView: StreamList = (function(superClass) {
        extend(StreamList, superClass);

        function StreamList() {
          this.checkScroll = bind(this.checkScroll, this);
          return StreamList.__super__.constructor.apply(this, arguments);
        }

        StreamList.prototype.template = _.template(Templates.streams);

        StreamList.prototype.itemView = StreamItem;

        StreamList.prototype.itemViewContainer = "#items";

        StreamList.prototype.id = "streamlist";

        StreamList.prototype.events = {
          "scroll": "checkScroll"
        };

        StreamList.prototype.checkScroll = function(e) {
          var margin, scrollTop, virtualHeight;
          virtualHeight = this.$("> div").height();
          scrollTop = this.$el.scrollTop() + this.$el.height();
          margin = 200;
          if ((scrollTop + margin) >= virtualHeight) {
            return this.trigger("scroll:more");
          }
        };

        return StreamList;

      })(AppViews.CompositeView)
    };
  });

}).call(this);
