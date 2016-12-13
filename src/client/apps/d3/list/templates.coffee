# modular template loading
define (require) ->
    datavis: require("text!apps/d3/list/templates/datavis.htm")
    layout: require("text!apps/d3/list/templates/layout.htm")
