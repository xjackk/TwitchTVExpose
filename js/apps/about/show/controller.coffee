# db list controller
define ["msgbus", "apps/about/show/views", "controller/_base"], (msgBus, Views, AppController) ->
    # the module API will pass in the glogal collection of ccys
    class Controller extends AppController
        initialize:(options)->
            entities=msgBus.reqres.request "book:entities"
            ossentities=msgBus.reqres.request "oss:entities"
            #console.log ossentities
            @layout = @getLayoutView()

            @listenTo @layout, "show", =>
                @aboutRegion()
                @bookRegion entities
                @ossRegion ossentities
                @ossCaroRegion ossentities

            @show @layout,
                loading:
                    entities: entities


        aboutRegion:  ->
            view = @getAboutView()
            @layout.aboutRegion.show view


        bookRegion: (collection) ->
            view = @getBookView collection
            @layout.bookRegion.show view

        ossRegion: (collection) ->
            view = @getOssView collection
            @layout.ossRegion.show view

        ossCaroRegion: (collection) ->
            view = @getOssCaroView collection
            @layout.ossCaroRegion.show view

        getOssView: (collection) ->
            new Views.Oss
                collection: collection

        getOssCaroView: (collection) ->
            new Views.OssCaro
                collection: collection

        getBookView: (collection) ->
            new Views.Books
                collection: collection

        getAboutView:  ->
            new Views.About

        getLayoutView: ->
            new Views.Layout


