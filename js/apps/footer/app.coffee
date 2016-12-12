# footer app/module.
define ["msgbus","apps/footer/show/controller"], (msgBus, Controller) ->
    channel = msgBus.appChannel    

	API =
		show: ->
			new Controller
				region: channel.request "footer:region"

	channel.on "start:footer:app", ->
		API.show()