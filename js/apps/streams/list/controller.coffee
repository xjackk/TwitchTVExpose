define ["msgbus", "apps/streams/list/views", "controller/_base"  ], (msgBus, Views, AppController) ->
    class Controller extends AppController
        initialize:(options={})->
            {model} = options
            #console.log "streams:list:controller", options
            streamEntities = msgBus.reqres.request "search:stream:entities", model.get("game").name
            view = @getListView streamEntities
            @listenTo view, "childview:stream:item:clicked", (child, args) ->  # listen to events from itemview (we've overridden the eventnamePrefix to childview)
                #console.log "game:item:clicked" , args.model
                msgBus.events.trigger "app:playa:show", args.model

            @show view,
                loading: true

        getListView: (collection) ->
            new Views.ListView
                collection: collection