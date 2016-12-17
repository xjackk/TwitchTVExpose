define [ "msgbus", "apps/streams/list/controller", "class/app" ], (msgBus, Controller, App) ->
    app = new App "streams"
    
    appChannel = msgBus.appChannel

    API =
        list:(region, name) ->
            new Controller
                region: region
                name: name

    appChannel.on "app:stream:list", (region, name) ->
        API.list region, name

    appChannel.on app.startEvent, ->
        console.log "handled: #{app.startEvent}"

    app