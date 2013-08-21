# LS currency app/module
define ["msgbus", "marionette", "apps/oauth/show/controller"], (msgBus, Marionette, Controller) ->

	class Router extends Marionette.AppRouter
		appRoutes:
			"oauth": "oauth"

	API =
		oauth: ->
			new Controller

	msgBus.commands.setHandler "start:oauth:app", ->
		new Router
			controller: API