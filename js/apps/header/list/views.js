// Generated by CoffeeScript 1.12.1
(function() {
  var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  define(['views/_base', 'apps/header/list/templates'], function(AppView, Templates) {
    var HeaderLayout, HeaderList, Loginview, _itemview;
    _itemview = (function(superClass) {
      extend(_itemview, superClass);

      function _itemview() {
        return _itemview.__super__.constructor.apply(this, arguments);
      }

      _itemview.prototype.template = _.template(Templates.item);

      _itemview.prototype.tagName = "li";

      return _itemview;

    })(AppView.ItemView);
    return {
      LoginView: Loginview = (function(superClass) {
        extend(Loginview, superClass);

        function Loginview() {
          return Loginview.__super__.constructor.apply(this, arguments);
        }

        Loginview.prototype.template = _.template(Templates.login);

        Loginview.prototype.el = "#login";

        return Loginview;

      })(AppView.ItemView),
      HeaderView: HeaderList = (function(superClass) {
        extend(HeaderList, superClass);

        function HeaderList() {
          return HeaderList.__super__.constructor.apply(this, arguments);
        }

        HeaderList.prototype.template = _.template(Templates.header);

        HeaderList.prototype.itemView = _itemview;

        HeaderList.prototype.itemViewContainer = "ul";

        return HeaderList;

      })(AppView.CompositeView),
      Layout: HeaderLayout = (function(superClass) {
        extend(HeaderLayout, superClass);

        function HeaderLayout() {
          return HeaderLayout.__super__.constructor.apply(this, arguments);
        }

        HeaderLayout.prototype.template = _.template(Templates.layout);

        HeaderLayout.prototype.regions = {
          listRegion: "#list-region"
        };

        return HeaderLayout;

      })(AppView.Layout)
    };
  });

}).call(this);
