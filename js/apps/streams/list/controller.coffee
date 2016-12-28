define ["msgbus", "apps/streams/list/views", "controller/_base" ], (msgBus, Views, AppController) ->
    appChannel = msgBus.appChannel

    class Controller extends AppController
        initialize:(options={})->
            {name} = options
            console.log "streams:list:controller OPTIONS", options
            streamEntities = appChannel.request "search:stream:entities", name
            view = @getLayoutView streamEntities

            @listenTo view, "childview:stream:item:clicked", (child, args) ->  # listen to events from itemview (we've overridden the eventnamePrefix to childview)
                appChannel.trigger "app:playa:show", args.model

            @listenTo view, "scroll:more", ->
                appChannel.request "streams:fetchmore"  # event handled by the streams entitiy

            @show view,
                loading: true

        getLayoutView: (collection) ->
            new Views.Layout
                collection: collection