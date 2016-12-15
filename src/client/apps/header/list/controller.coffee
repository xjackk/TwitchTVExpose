# header list controller
define ["msgbus", "apps/header/list/views", "controller/_base", "entities/appstate", "entities/header" ], (msgBus, HViews, AppController, AppState) ->
    channel = msgBus.appChannel
    console.log "headerlist views:", HViews
    console.log "Appstate:", AppState

    class Controller extends AppController
        initialize: ->
            links = channel.request "header:entities"
            #console.log @appstate
            @layout = @getLayoutView()

            # new appstate is now a property of the controller have the controller listen to the specific attribute
            # so from anywhere you can set the appstate's loginStatus to T/F and this button will toggle
            @listenTo AppState, "change:loginStatus", (model, status) =>
                @loginView.close() if status is true
                @loginView.render() if status is false

            @listenTo @layout, "show", =>
                @listRegion links
                @loginView = @getLoginView AppState
                @loginView.render()  #stick-it into the DOM

            @show @layout

        getHeaderView:(links)->
            new HViews.HeaderView
                collection: links

        getLoginView: (model) ->
            new HViews.Login_View
                model: model

        getLayoutView: ->
            new HViews.LayoutView

        listRegion: (links)  ->
            view = @getHeaderView links
            @layout.listRegion.show view

