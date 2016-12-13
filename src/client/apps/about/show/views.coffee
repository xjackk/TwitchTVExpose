define ['apps/about/show/templates', 'views/_base', 'd3'], (Templates, AppView) ->

    class Book extends AppView.ItemView
        template: _.template(Templates.bookitem)
        tagName: "tr"

    class Oss extends AppView.ItemView
        template: _.template(Templates.ossitem)
        tagName: "tr"

    Books: class Books extends AppView.CompositeView
        template: _.template(Templates.books)
        itemView: Book
        itemViewContainer: "tbody"

    Oss: class Osslist extends AppView.CompositeView
        template: _.template(Templates.oss)
        itemView: Oss
        itemViewContainer: "tbody"

    About: class _item extends AppView.ItemView
        template: _.template(Templates.about)

    Layout: class DataVisLayout extends AppView.Layout
        template: _.template(Templates.layout)
        regions:
            aboutRegion: "#about-region"
            bookRegion: "#book-region"
            ossRegion: "#oss-region"


