define ['marionette', 'apps/about/show/templates',  'd3'], (Marionette, Templates, D3) ->

    class Book extends Marionette.ItemView
        template: _.template(Templates.bookitem)
        tagName: "tr"

    class Oss extends Marionette.ItemView
        template: _.template(Templates.ossitem)
        tagName: "tr"

    Books: class Books extends Marionette.CompositeView
        template: _.template(Templates.books)
        itemView: Book
        itemViewContainer: "tbody"

    Oss: class Osslist extends Marionette.CompositeView
        template: _.template(Templates.oss)
        itemView: Oss
        itemViewContainer: "tbody"

    About: class _item extends Marionette.ItemView
        template: _.template(Templates.about)

    Layout: class DataVisLayout extends Marionette.Layout
        template: _.template(Templates.layout)
        regions:
            aboutRegion: "#about-region"
            bookRegion: "#book-region"
            ossRegion: "#oss-region"


