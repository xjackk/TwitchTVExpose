# footer app/module.
define ["msgbus","apps/footer/show/controller"], (msgBus, Controller) ->
	appChannel = msgBus.appChannel

	API =
		show: ->
			new Controller
				#region: msgBus.reqres.request "footer:region"

	appChannel.on "start:footer:app", ->
		API.show()