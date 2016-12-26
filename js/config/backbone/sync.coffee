define ["backbone", "msgbus"], (Backbone, msgBus) ->
    appChannel = msgBus.appChannel

    _sync = Backbone.sync
    
    Backbone.sync = (method, entity, options = {}) ->
    	_.defaults options,
    		beforeSend: _.bind(methods.beforeSend, entity)
    		complete: _.bind(methods.complete, entity)
    
    	sync = _sync(method, entity, options)
    	if !entity._fetch and method is "read"
    		entity._fetch = sync
    	sync
    
    methods =
    	beforeSend: ->
    		@trigger "sync:start", @
    	complete: ->
    		@trigger "sync:stop", @



    appChannel.on "when:fetched", (entities, callback) ->
        xhrs = _.chain([entities]).flatten().pluck("_fetch").value()
        $.when(xhrs...).done ->
            callback()			