# modular template loading
define (require) ->
	about: require("text!apps/oauth/show/templates/about.htm")
	layout: require("text!apps/oauth/show/templates/layout.htm")