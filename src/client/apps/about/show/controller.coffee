define ["msgbus", "apps/about/show/views", "controller/_base"], (msgBus, AppView, AppController) ->
    dataChannel = msgBus.dataChannel

    console.log "about show", AppView

    class Controller extends AppController
        initialize:(options)->
            @entities    = dataChannel.request "reference:entities"      # msgBus.reqres.request "reference:entities"
            @ossentities = dataChannel.request "oss:entities"            # msgBus.reqres.request "oss:entities"
            @layout = @getLayoutView()

            @listenTo @layout, "show", =>
                @aboutRegion()
                @bookRegion @entities
                @ossRegion @ossentities

            @show @layout,
                loading:
                    entities: [@entities, @ossentities]


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
            new AppView.Oss
                collection: collection

        getBookView: (collection) ->
            new AppView.Books
                collection: collection

        getAboutView:  ->
            new AppView.About

        getLayoutView: ->
            new AppView.Layout