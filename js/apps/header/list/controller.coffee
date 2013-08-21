# header list controller
define ["msgbus","apps/header/list/views", "controller/_base", "entities/header"], (msgBus, Views, AppController) ->
    class Controller extends AppController
        initialize: ->
            links = msgBus.reqres.request "header:entities"
            @appstate = msgBus.reqres.request "get:current:appstate"
            @layout = @getLayoutView()

            @listenTo @layout, "show", =>
                @listRegion links
                @loginView = @getLoginView @appstate  # by calling render we attache view the it's DOM @el  got it?
                @loginView.render()  # stick-it into the DOM

            # new appstate is now a property of the controller have the controller listen to the specific attribute
            @listenTo @appstate, "change:loginStatus", (model, status) =>
                if status is true     #then we can hide the login button
                    #console.log "(Header List Controller)accessToken : ", @appstate, status, model
                    @loginView?.close()
                else
                    @loginView = @getLoginView @appstate  # by calling render we attache view the it's DOM @el  got it?
                    @loginView.render()  # stick-it into the DOM (not DRY enough, could be refactored)

            @show @layout

        getHeaderView:(links)->
            new Views.HeaderView
                collection: links

        getLoginView: (model) ->
            new Views.LoginView
                model: model

        getLayoutView: ->
            new Views.Layout

        listRegion: (links)  ->
            view = @getHeaderView links
            @layout.listRegion.show view

        #loginRegion: ()  ->
        #    view = @getLoginView @appstate
        #    @layout.loginRegion.show view

# this method would require a public API
#    msgBus.events.on "login:status:change", status =>
#        if status is true
#            @layout.loginRegion.close()
#        else
#            @layout.loginRegion.show()