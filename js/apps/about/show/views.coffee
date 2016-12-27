define ["marionette", "apps/about/show/templates"], (Mn, Templates) ->

    class BookRowView extends Mn.View
        template: _.template(Templates.bookItem)
        tagName: "tr"

    class OssRowView extends Mn.View
        template: _.template(Templates.ossItem)
        tagName: "tr"

    class About extends Mn.View
        template: _.template(Templates.about)


    class BookTableBody extends Mn.CollectionView
        tagName: "tbody"
        childView: BookRowView

    class OssTableBody extends Mn.CollectionView
        tagName: "tbody"
        childView: OssRowView


    class BookTableView extends Mn.View
        template: _.template(Templates.bookTable)
        regions:
            body:
                el: 'tbody'
                replaceElement: true

        onRender: ->
            @showChildView "body", new BookTableBody
                collection: @collection

    class OSSTableView extends Mn.View
        template: _.template(Templates.ossTable)
        regions:
            body:
                el: 'tbody'
                replaceElement: true

        onRender: ->
            @showChildView "body", new OssTableBody
                collection: @collection


    LayoutView: class AppLayout extends Mn.View
        template: _.template(Templates.layout)
        regions:
            aboutRegion:    "#about-region"
            bookRegion:     "#book-region"
            ossRegion:      "#oss-region"

        onRender: ->
            console.log 'getOptions', @getOption("bookEntities")
            console.log 'getOptions', @getOption("ossEntities")

            @showChildView "aboutRegion", new About()
            @showChildView "bookRegion", new BookTableView 
                collection: @getOption("bookEntities")
            @showChildView "ossRegion", new OSSTableView 
                collection: @getOption("ossEntities")