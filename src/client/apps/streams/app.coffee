define [ "msgbus", "apps/streams/list/controller" ], (msgBus, Controller) ->
    channel = msgBus.appChannel

    API =
        list:(region, name) ->
            new Controller
                region: region
                name: name

    channel.on "app:stream:list", (region, name) ->
        API.list region, name