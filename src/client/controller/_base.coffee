define ["marionette", "msgbus"], (Marionette, msgBus) ->
	channel = msgBus.appChannel
	componentChannel = msgBus.componentChannel

	class AppController extends Marionette.Controller
		constructor: (options = {}) ->
			@region = options.region or channel.request "default:region"
			#App.execute "register:instance", @, @_instance_id
			#@_instance_id = _.uniqueId("controller")
			#channel.trigger "register:instance", @, @_instance_id
			super options

		close: (args...) ->
			delete @region
			delete @options
			#channel.trigger "unregister:instance", @, @_instance_id
			super args

		show: (view, options = {}) ->
			_.defaults options,
				loading: false
				region: @region

			@_setMainView view
			@_manageView view, options

		_setMainView: (view) ->
			return if @_mainView
			@_mainView = view
			@listenTo view, "close", @close

		_manageView: (view, options) ->
			if options.loading
				#important!  using the component msg channle to request the loading controller  it's listening on this channel'
				componentChannel.request "show:loading", view, options
			else
				options.region.show view
