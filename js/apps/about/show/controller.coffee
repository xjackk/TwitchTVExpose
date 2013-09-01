# db list controller
define ["msgbus", "apps/about/show/views", "controller/_base"], (msgBus, Views, AppController) ->
    # the module API will pass in the glogal collection of ccys
    class Controller extends AppController
        initialize:(options)->
            #entities=msgBus.reqres.request "games:top:entities"
            #console.log entities
            @layout = @getLayoutView()

            @listenTo @layout, "show", =>
                @aboutRegion()
                @bookRegion()

            @show @layout


        aboutRegion:  ->
            view = @getAboutView()
            @layout.aboutRegion.show view


        bookRegion:  ->
            view = @getbookView()
            @layout.aboutRegion.show view

        getBookView: ->
            new Views.Book

        getAboutView:  ->
            new Views.About

        getLayoutView: ->
            new Views.Layout


