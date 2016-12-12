// Generated by CoffeeScript 1.9.2
(function() {
  var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  define(['views/_base', 'apps/footer/show/templates'], function(AppViews, Templates) {
    var ShowFooterView;
    return {
      ItemView: ShowFooterView = (function(superClass) {
        extend(ShowFooterView, superClass);

        function ShowFooterView() {
          return ShowFooterView.__super__.constructor.apply(this, arguments);
        }

        ShowFooterView.prototype.template = _.template(Templates.footer);

        ShowFooterView.prototype.modelEvents = {
          "change": "render"
        };

        return ShowFooterView;

      })(AppViews.ItemView)
    };
  });

}).call(this);
