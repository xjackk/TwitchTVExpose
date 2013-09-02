# list currency views
define ['apps/about/show/templates', 'views/_base', 'd3'], (Templates, AppView) ->

    class Book extends AppView.ItemView
        template: _.template(Templates.bookitem)
        tagName: "tr"

    class Oss extends AppView.ItemView
        template: _.template(Templates.ossitem)
        tagName: "tr"

    class OssCI extends AppView.ItemView  # carosel item
        template: _.template(Templates.osscaroitem)
        className: "item"  # the view wrapped in <div class="item"></div>

    OssCaro: class OssCarolist extends AppView.CompositeView
        template: _.template(Templates.osscaro)
        itemView: OssCI
        itemViewContainer: ".carousel-inner"
        id: "carousel-oss"
        className: "carousel slide"

        ui:
            caro: "#carousel-oss"
            slides: ".carousel-inner"

        serializeData: ->
            itemCount: @collection.length

        onShow:->
            #console.log "onShow", @ui.slides
            @ui.slides.children("div").first().addClass "active"
            @ui.caro.carousel "cycle"

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
            ossCaroRegion: "#osscaro-region"
            bookCaroRegion: "#bookcaro-region"


