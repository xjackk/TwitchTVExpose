# show footer views.
define ['marionette', 'apps/footer/show/templates'], (Marionette, Templates) ->

	ItemView: class ShowFooterView extends Marionette.ItemView
		template: _.template(Templates.footer)

		modelEvents:
			"change" : "render"