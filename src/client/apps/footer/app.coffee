# footer app/module.
define ["msgbus", "apps/footer/show/controller", "class/app"], (msgBus, Controller, App) ->
	app = new App "footer"

	channel = msgBus.appChannel    

	API =
		show: ->
			new Controller
				region: channel.request "footer:region"

	channel.on app.startEvent, ->
		console.log "handled: #{app.startEvent}"
		API.show()

	app