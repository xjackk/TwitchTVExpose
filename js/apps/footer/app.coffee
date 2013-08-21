# footer app/module.
define ["msgbus","apps/footer/show/controller"], (msgBus, Controller) ->
	API =
		show: ->
			new Controller
				region: msgBus.reqres.request "footer:region"

	msgBus.commands.setHandler "start:footer:app", ->
		API.show()