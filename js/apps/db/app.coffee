# LS currency app/module
define ["msgbus", "marionette", "apps/db/list/controller"], (msgBus, Marionette, ListDBController) ->

	class Router extends Marionette.AppRouter
		appRoutes:
			"db": "datavis"

	API =
		datavis: ->
			new ListDBController

	msgBus.commands.setHandler "start:db:app", ->
		new Router
			controller: API