# db list controller
define ["msgbus", "apps/about/show/views", "controller/_base"], (msgBus, Views, AppController) ->
    # the module API will pass in the glogal collection of ccys
    class Controller extends AppController
        initialize:(options)->
            entities=msgBus.reqres.request "book:entities"
            console.log entities
            @layout = @getLayoutView()

            @listenTo @layout, "show", =>
                @aboutRegion()
                @bookRegion entities

            @show @layout,
                loading:
                    entities: entities


        aboutRegion:  ->
            view = @getAboutView()
            @layout.aboutRegion.show view


        bookRegion: (collection) ->
            view = @getBookView collection
            @layout.bookRegion.show view

        getBookView: (collection) ->
            new Views.Books
                collection: collection

        getAboutView:  ->
            new Views.About

        getLayoutView: ->
            new Views.Layout


