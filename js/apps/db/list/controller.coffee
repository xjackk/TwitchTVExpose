# db list controller
define ["msgbus", "apps/db/list/views", "controller/_base"], (msgBus, Views, AppController) ->
	# the module API will pass in the glogal collection of ccys
	class Controller extends AppController
		initialize:(options)->
			@layout = @getLayoutView()
			@listenTo @layout, "show", =>
				@visRegion()
			@show @layout

		visRegion:  ->
			view = @getDataVisView()
			@layout.dataVisRegion.show view

		getDataVisView:  ->
			new Views.DataVis

		getLayoutView: ->
			new Views.Layout
