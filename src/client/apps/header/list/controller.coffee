define ["msgbus", "apps/header/list/views", "controller/_base" ], (msgBus, Views, AppController) ->
    dataChannel = msgBus.dataChannel

    class Controller extends AppController
        initialize: ->
            @links = dataChannel.request "header:entities"
            @appState = dataChannel.request "get:current:appstate"
            @layout = @getLayoutView()

            # new appstate is now a property of the controller have the controller listen to the specific attribute
            # so from anywhere you can set the appstate's loginStatus to T/F and this button will toggle
            @listenTo @appState, "change:loginStatus", (model, status) =>
                @loginView?.close() if status is true
                @loginView?.render() if status is false

            @listenTo @layout, "show", =>
                @listRegion @links
                @loginView = @getLoginView @appState
                @loginView?.render()  #stick-it into the DOM

            @show @layout,
                loading:
                    entities: [@links, @appState]

        getHeaderView: (links) ->
            new Views?.HeaderView
                collection: links

        getLoginView: (model) ->
            new Views?.Login_View
                model: model

        getLayoutView: ->
            new Views?.LayoutView

        listRegion: (links) ->
            view = @getHeaderView links
            @layout.listRegion?.show view
