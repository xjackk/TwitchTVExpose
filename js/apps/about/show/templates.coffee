# modular template loading
define (require) ->
    about: require("text!apps/about/show/templates/about.htm")
    layout: require("text!apps/about/show/templates/layout.htm")
    alert: require("text!apps/about/show/templates/alert.htm")