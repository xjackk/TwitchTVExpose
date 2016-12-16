define ["msgbus", "backbone"], (Bus, Backbone) ->
	dataChannel = Bus.dataChannel

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
			

	#wire up the reply 
	dataChannel.reply "when:fetched", (entities, callback)->
		xhrs = _.chain([entities]).flatten().pluck("_fetch").value()
		Backbone.$.when(xhrs...).done ->
			console.log "when:fetched callback..."
			callback()            