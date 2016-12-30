define ["backbone", "msgbus"], (Backbone, msgBus) ->
    appChannel = msgBus.appChannel

    _sync = Backbone.sync
    
    # override .sync to add xhr/._fetch promise property
    Backbone.sync = (method, entity, options = {}) ->
        _.defaults options,
            beforeSend: _.bind(methods.beforeSend, entity)
            complete: _.bind(methods.complete, entity)

        sync = _sync(method, entity, options)
        if !entity._fetch and method is "read"
            entity._fetch = sync
        sync

    # trigger custom messages on our radio channel
    # used by NProgress UI start/stop globally
    methods =
        beforeSend: ->
            appChannel.trigger "sync:start", @  #NP.start()
        complete: ->
            appChannel.trigger "sync:stop", @   #NP.done()

    appChannel.on "when:fetched", (entities, callback) ->
        xhrs = _.chain([entities]).flatten().pluck("_fetch").value()
        $.when(xhrs...).done ->
            callback()