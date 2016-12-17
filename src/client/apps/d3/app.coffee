# example app: using D3 in marionette view
define ["marionette", "msgbus", "apps/d3/list/controller", "class/app"], (Marionette, msgBus, Controller, App) ->
	app = new App "D3"
	channel = msgBus.appChannel


	class Router extends Marionette.AppRouter
		appRoutes:
			"d3": "show"

	API =
		show: ->
			new Controller


	channel.on app.startEvent, ->
		console.log "handled: #{app.startEvent}"
		new Router
			controller: API
	app
#	