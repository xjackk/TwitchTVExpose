define ["msgbus"], (msgBus) ->
    appChannel = msgBus.appChannel

    appChannel.on "when:fetched", (entities, callback) ->
        xhrs = _.chain([entities]).flatten().pluck("_fetch").value()
        $.when(xhrs...).done ->
            callback()