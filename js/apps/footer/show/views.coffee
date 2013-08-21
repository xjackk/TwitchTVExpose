# show footer views.
define ['views/_base', 'apps/footer/show/templates'], (AppViews, Templates) ->

	ItemView: class ShowFooterView extends AppViews.ItemView
		template: _.template(Templates.footer)

		modelEvents:
			"change" : "render"