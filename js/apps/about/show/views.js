// Generated by CoffeeScript 1.9.2
(function() {
  var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  define(['apps/about/show/templates', 'views/_base', 'd3'], function(Templates, AppView) {
    var Book, Books, DataVisLayout, Oss, Osslist, _item;
    Book = (function(superClass) {
      extend(Book, superClass);

      function Book() {
        return Book.__super__.constructor.apply(this, arguments);
      }

      Book.prototype.template = _.template(Templates.bookitem);

      Book.prototype.tagName = "tr";

      return Book;

    })(AppView.ItemView);
    Oss = (function(superClass) {
      extend(Oss, superClass);

      function Oss() {
        return Oss.__super__.constructor.apply(this, arguments);
      }

      Oss.prototype.template = _.template(Templates.ossitem);

      Oss.prototype.tagName = "tr";

      return Oss;

    })(AppView.ItemView);
    return {
      Books: Books = (function(superClass) {
        extend(Books, superClass);

        function Books() {
          return Books.__super__.constructor.apply(this, arguments);
        }

        Books.prototype.template = _.template(Templates.books);

        Books.prototype.itemView = Book;

        Books.prototype.itemViewContainer = "tbody";

        return Books;

      })(AppView.CompositeView),
      Oss: Osslist = (function(superClass) {
        extend(Osslist, superClass);

        function Osslist() {
          return Osslist.__super__.constructor.apply(this, arguments);
        }

        Osslist.prototype.template = _.template(Templates.oss);

        Osslist.prototype.itemView = Oss;

        Osslist.prototype.itemViewContainer = "tbody";

        return Osslist;

      })(AppView.CompositeView),
      About: _item = (function(superClass) {
        extend(_item, superClass);

        function _item() {
          return _item.__super__.constructor.apply(this, arguments);
        }

        _item.prototype.template = _.template(Templates.about);

        return _item;

      })(AppView.ItemView),
      Layout: DataVisLayout = (function(superClass) {
        extend(DataVisLayout, superClass);

        function DataVisLayout() {
          return DataVisLayout.__super__.constructor.apply(this, arguments);
        }

        DataVisLayout.prototype.template = _.template(Templates.layout);

        DataVisLayout.prototype.regions = {
          aboutRegion: "#about-region",
          bookRegion: "#book-region",
          ossRegion: "#oss-region"
        };

        return DataVisLayout;

      })(AppView.Layout)
    };
  });

}).call(this);
