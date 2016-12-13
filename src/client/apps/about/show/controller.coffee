define ["msgbus", "apps/about/show/views", "controller/_base"], (msgBus, Views, AppController) ->
    channel = msgBus.appChannel

    class Controller extends AppController
        initialize:(options)->
            entities    = channel.request "reference:entities"      # msgBus.reqres.request "reference:entities"
            ossentities = channel.request "oss:entities"            # msgBus.reqres.request "oss:entities"
            #console.log ossentities
            @layout = @getLayoutView()

            @listenTo @layout, "show", =>
                @aboutRegion()
                @bookRegion entities
                @ossRegion ossentities

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

        getOssView: (collection) ->
            new Views.Oss
                collection: collection

        getBookView: (collection) ->
            new Views.Books
                collection: collection

        getAboutView:  ->
            new Views.About

        getLayoutView: ->
            new Views.Layout


