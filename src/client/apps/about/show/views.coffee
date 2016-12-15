define ['views/_base', 'apps/about/show/templates',  'd3'], (AppView, Templates, D3) ->

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

    About: class AboutItem extends AppView.ItemView
        template: _.template(Templates.about)

    Layout: class AboutLayout extends AppView.Layout
        template: _.template(Templates.layout)
        regions:
            aboutRegion: "#about-region"
            bookRegion: "#book-region"
            ossRegion: "#oss-region"