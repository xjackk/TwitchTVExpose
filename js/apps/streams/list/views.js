// Generated by CoffeeScript 1.6.3
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  define(['views/_base', 'apps/streams/list/templates'], function(AppViews, Templates) {
    var StreamItem, StreamList, _ref, _ref1;
    StreamItem = (function(_super) {
      __extends(StreamItem, _super);

      function StreamItem() {
        _ref = StreamItem.__super__.constructor.apply(this, arguments);
        return _ref;
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
      ListView: StreamList = (function(_super) {
        __extends(StreamList, _super);

        function StreamList() {
          this.checkScroll = __bind(this.checkScroll, this);
          _ref1 = StreamList.__super__.constructor.apply(this, arguments);
          return _ref1;
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
          console.log("virtualHeight:", virtualHeight, "scrollTop:", scrollTop, "elHeight", this.$el.height());
          if ((scrollTop + margin) >= virtualHeight) {
            return this.trigger("scroll:more");
          }
        };

        return StreamList;

      })(AppViews.CompositeView)
    };
  });

}).call(this);
