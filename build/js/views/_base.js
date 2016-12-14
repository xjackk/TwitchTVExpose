(function() {
  var slice = [].slice,
    extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  define(["backbone", "marionette"], function(Backbone, Marionette) {
    var _AppCollectionView, _AppCompositeView, _AppItemView, _AppLayoutView, _remove;
    _remove = Marionette.View.prototype.remove;
    _.extend(Marionette.View.prototype, {
      addOpacityWrapper: function(init) {
        if (init == null) {
          init = true;
        }
        return this.$el.toggleWrapper({
          className: "opacity"
        }, init);
      },
      remove: function() {
        var args, ref, wrapper;
        args = 1 <= arguments.length ? slice.call(arguments, 0) : [];
        if ((ref = this.model) != null ? typeof ref.isDestroyed === "function" ? ref.isDestroyed() : void 0 : void 0) {
          wrapper = this.$el.toggleWrapper({
            className: "opacity",
            backgroundColor: "red"
          });
          wrapper.fadeOut(400, function() {
            return $(this).remove();
          });
          return this.$el.fadeOut(400, (function(_this) {
            return function() {
              return _remove.apply(_this, args);
            };
          })(this));
        } else {
          return _remove.apply(this, args);
        }
      },
      templateHelpers: function() {
        var url;
        ({
          linkTo: function(name, url, options) {
            if (options == null) {
              options = {};
            }
          }
        });
        _.defaults(options, {
          external: false
        });
        if (!options.external) {
          url = "#" + url;
        }
        return "<a href='" + url + "'>" + (this.escape(name)) + "</a>";
      }
    });
    return {
      ItemView: _AppItemView = (function(superClass) {
        extend(_AppItemView, superClass);

        function _AppItemView() {
          return _AppItemView.__super__.constructor.apply(this, arguments);
        }

        return _AppItemView;

      })(Marionette.ItemView),
      CollectionView: _AppCollectionView = (function(superClass) {
        extend(_AppCollectionView, superClass);

        function _AppCollectionView() {
          return _AppCollectionView.__super__.constructor.apply(this, arguments);
        }

        return _AppCollectionView;

      })(Marionette.CollectionView),
      CompositeView: _AppCompositeView = (function(superClass) {
        extend(_AppCompositeView, superClass);

        function _AppCompositeView() {
          return _AppCompositeView.__super__.constructor.apply(this, arguments);
        }

        return _AppCompositeView;

      })(Marionette.CompositeView),
      LayoutView: _AppLayoutView = (function(superClass) {
        extend(_AppLayoutView, superClass);

        function _AppLayoutView() {
          return _AppLayoutView.__super__.constructor.apply(this, arguments);
        }

        return _AppLayoutView;

      })(Marionette.LayoutView)
    };
  });

}).call(this);
