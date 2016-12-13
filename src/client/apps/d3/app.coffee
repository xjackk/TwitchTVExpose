# example app: using D3 in marionette view
define ["marionette", "msgbus", "apps/d3/list/controller"], (Marionette, msgBus, Controller) ->
	channel = msgBus.appChannel


	class Router extends Marionette.AppRouter
		appRoutes:
			"d3": "tedifyouseethisyousmell"

	API =
		tedifyouseethisyousmell: ->
			new Controller


	channel.on "start:d3:app", ->
		new Router
			controller: API