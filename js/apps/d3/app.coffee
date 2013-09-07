# example app: using D3 in marionette view
define ["msgbus", "marionette", "apps/d3/list/controller"], (msgBus, Marionette, Controller) ->

	class Router extends Marionette.AppRouter
		appRoutes:
			"d3": "poopie"

	API =
		poopie: ->
			new Controller

	msgBus.commands.setHandler "start:d3:app", ->
		new Router
			controller: API