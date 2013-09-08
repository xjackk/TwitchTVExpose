define [ "msgbus", "apps/streams/list/controller" ], (msgBus, Controller) ->

    API =
        list:(region, model) ->
            new Controller
                region: region
                model: model

    msgBus.commands.setHandler "app:stream:list", (region, model) ->
        API.list region, model