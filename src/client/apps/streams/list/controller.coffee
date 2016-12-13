define ["msgbus", "apps/streams/list/views", "controller/_base", "entities/appstate"  ], (msgBus, Views, AppController, AppState) ->
    channel = msgBus.appChannel

    class Controller extends AppController
        initialize:(options={})->
            {name} = options

            streamEntities = channel.request "search:stream:entities", name
            view = @getListView streamEntities

            @listenTo view, "childview:stream:item:clicked", (child, args) ->  # listen to events from itemview (we've overridden the eventnamePrefix to childview)
                channel.trigger "app:playa:show", args.model

            @listenTo view, "scroll:more", ->
                channel.request "streams:fetchmore"  # event handled by the streams entitiy

            @show view,
                loading: true

        getListView: (collection) ->
            new Views.ListView
                collection: collection