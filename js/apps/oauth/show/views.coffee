# list currency views
define ['apps/oauth/show/templates', 'views/_base', 'd3'], (Templates, AppView) ->

	About: class _item extends AppView.ItemView
		template: _.template(Templates.about)



	Layout: class DataVisLayout extends AppView.Layout
		template: _.template(Templates.layout)
		regions:
			panelRegion: "#panel-region"
			aboutRegion: "#datavis-region"