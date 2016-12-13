define ["msgbus"], (msgBus) ->
    dataChannel = msgBus.dataChannel

    dataChannel.reply "when:fetched", (entities, callback) ->
        xhrs = _.chain([entities]).flatten().pluck("_fetch").value()
        $.when(xhrs...).done ->
            callback()