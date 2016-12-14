(function() {
  var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  define(['views/_base', 'components/loading/templates'], function(AppViews, Templates) {
    var _LoadingView;
    return {
      Loading: _LoadingView = (function(superClass) {
        extend(_LoadingView, superClass);

        function _LoadingView() {
          return _LoadingView.__super__.constructor.apply(this, arguments);
        }

        _LoadingView.prototype.template = _.template(Templates.main);

        _LoadingView.prototype.className = "loading-container";

        _LoadingView.prototype.onShow = function() {
          var opts;
          opts = this._getOptions();
          return this.$el.spin(opts);
        };

        _LoadingView.prototype.onClose = function() {
          return this.$el.spin(false);
        };

        _LoadingView.prototype._getOptions = function() {
          return {
            lines: 10,
            length: 6,
            width: 2.5,
            radius: 7,
            corners: 1,
            rotate: 9,
            direction: 1,
            color: '#000',
            speed: 1,
            trail: 60,
            shadow: false,
            hwaccel: true,
            className: 'spinner',
            zIndex: 2e9,
            top: 'auto',
            left: 'auto'
          };
        };

        return _LoadingView;

      })(AppViews.ItemView)
    };
  });

}).call(this);
