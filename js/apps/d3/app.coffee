# LS currency app/module
define ["msgbus", "marionette", "apps/d3/list/controller"], (msgBus, Marionette, Controller) ->

	class Router extends Marionette.AppRouter
		appRoutes:
			"d3": "datavis"

	API =
		datavis: ->
			new Controller

	msgBus.commands.setHandler "start:d3:app", ->
		new Router
			controller: API