define [ "msgbus", "apps/streams/list/controller" ], (msgBus, Controller) ->
    appChannel = msgBus.appChannel

    API =
        list:(region, name) ->
            new Controller
                region: region
                name: name

    appChannel.on "app:streams:list", (region, name) ->
        API.list region, name