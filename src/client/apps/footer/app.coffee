# footer app/module.
define ["msgbus", "apps/footer/show/controller", "class/app"], (msgBus, Controller, App) ->
	app = new App "footer"

	channel = msgBus.appChannel    

	API =
		show: ->
			new Controller
				region: channel.request "footer:region"

	channel.on "start:footer:app", ->
        console.log "startup for FOOTER APP"	
		API.show()

	app