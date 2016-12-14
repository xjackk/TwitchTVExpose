(function() {
  var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  define(['views/_base', 'apps/header/list/templates'], function(BaseView, Templates) {
    var _HeaderLayout, _HeaderList, _Loginview, _itemview;
    console.log(BaseView);
    _itemview = (function(superClass) {
      extend(_itemview, superClass);

      function _itemview() {
        return _itemview.__super__.constructor.apply(this, arguments);
      }

      _itemview.prototype.template = _.template(Templates.item);

      _itemview.prototype.tagName = "li";

      return _itemview;

    })(BaseView.ItemView);
    return {
      LoginView: _Loginview = (function(superClass) {
        extend(_Loginview, superClass);

        function _Loginview() {
          return _Loginview.__super__.constructor.apply(this, arguments);
        }

        _Loginview.prototype.template = _.template(Templates.login);

        _Loginview.prototype.el = "#login";

        return _Loginview;

      })(BaseView.ItemView),
      HeaderView: _HeaderList = (function(superClass) {
        extend(_HeaderList, superClass);

        function _HeaderList() {
          return _HeaderList.__super__.constructor.apply(this, arguments);
        }

        _HeaderList.prototype.template = _.template(Templates.header);

        _HeaderList.prototype.itemView = _itemview;

        _HeaderList.prototype.itemViewContainer = "ul";

        return _HeaderList;

      })(BaseView.CompositeView),
      LayoutView: _HeaderLayout = (function(superClass) {
        extend(_HeaderLayout, superClass);

        function _HeaderLayout() {
          return _HeaderLayout.__super__.constructor.apply(this, arguments);
        }

        _HeaderLayout.prototype.template = _.template(Templates.layout);

        _HeaderLayout.prototype.regions = {
          listRegion: "#list-region"
        };

        return _HeaderLayout;

      })(BaseView.Layout)
    };
  });

}).call(this);
