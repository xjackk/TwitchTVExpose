# form component controller
# the module API will pass in the glogal collection of ccys
define ["msgbus", "controller/_base", "components/loading/views" ], (msgBus, AppController, Views) ->
	channel = msgBus.appChannel
	componentChannel = msgBus.componentChannel

	class LoadingController extends AppController
		initialize: (options) ->
			{ view, config } = options

			config = if _.isBoolean(config) then {} else config

			_.defaults config,
				loadingType: "spinner"
				entities: @getEntities(view)
				debug: false

			switch config.loadingType
				when "opacity"
					@region.currentView.$el.css "opacity", 0.5
				when "spinner"
					loadingView = @getLoadingView()
					@show loadingView
				else
					throw new Error("Invalid loadingType")

			@showRealView view, loadingView, config

		showRealView: (realView, loadingView, config) ->
			channel.request "when:fetched", config.entities, =>
				switch config.loadingType
					when "opacity"
						@region.currentView.$el.removeAttr "style"
					when "spinner"
						return realView.close() if @region?.currentView isnt loadingView
				@show realView unless config.debug
		getEntities: (view) ->
			_.chain(view).pick("model", "collection").toArray().compact().value()

		getLoadingView: ->
			new Views.Loading

	componentChannel.reply "show:loading", (view, options) ->
		new LoadingController
			view: view
			region: options.region
			config: options.loading
