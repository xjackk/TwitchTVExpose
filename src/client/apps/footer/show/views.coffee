# show footer views.
define ['views/_base', 'apps/footer/show/templates'], (AppView, Templates) ->


	console.log "Mn.View", AppView.View
	ItemView: class ShowFooterView extends AppView.ItemView
		template: _.template(Templates.footer)

		modelEvents:
			"change" : "render"