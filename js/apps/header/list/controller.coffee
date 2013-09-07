# header list controller
define ["msgbus","apps/header/list/views", "controller/_base", "entities/header"], (msgBus, Views, AppController) ->
    class Controller extends AppController
        initialize: ->
            links = msgBus.reqres.request "header:entities"
            @appstate = msgBus.reqres.request "get:current:appstate"
            #console.log @appstate
            @layout = @getLayoutView()

            # new appstate is now a property of the controller have the controller listen to the specific attribute
            # so from anywhere you can set the appstate's loginStatus to T/F and this button will toggle
            @listenTo @appstate, "change:loginStatus", (model, status) =>
                @loginView.close() if status is true
                @loginView.render() if status is false

            @listenTo @layout, "show", =>
                @listRegion links
                @loginView = @getLoginView @appstate
                @loginView.render()  #stick-it into the DOM

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