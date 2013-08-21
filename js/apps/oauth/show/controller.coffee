# db list controller
define ["msgbus", "apps/oauth/show/views", "controller/_base"], (msgBus, Views, AppController) ->
	# the module API will pass in the glogal collection of ccys
    # fuck you for calling me a wanker....
	class Controller extends AppController
		initialize:(options)->
			@layout = @getLayoutView()
			@listenTo @layout, "show", =>
				@aboutRegion()
			@show @layout

		aboutRegion:  ->
			view = @getAboutView()
			@layout.aboutRegion.show view

		getAboutView:  ->
			new Views.About

		getLayoutView: ->
			new Views.Layout
