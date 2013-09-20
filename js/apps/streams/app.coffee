define [ "msgbus", "apps/streams/list/controller" ], (msgBus, Controller) ->

    API =
        list:(region, name) ->
            new Controller
                region: region
                name: name

    msgBus.commands.setHandler "app:stream:list", (region, name) ->
        API.list region, name