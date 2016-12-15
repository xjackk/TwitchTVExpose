define ['views/_base', 'apps/footer/show/templates'], (AppView, Templates) ->

	ItemView: class ShowFooterView extends AppView.ItemView
		template: _.template(Templates.footer)
		tagName: "nav"
		className: "navbar navbar-default navbar-fixed-bottom hidden-xs"

		modelEvents:
			"change" : "render"
