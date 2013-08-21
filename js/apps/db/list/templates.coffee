# modular template loading
define (require) ->
	datavis: require("text!apps/db/list/templates/datavis.htm")
	layout: require("text!apps/db/list/templates/layout.htm")