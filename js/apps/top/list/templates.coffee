# modular template loading
define (require) ->
    gameitem: require("text!apps/top/list/templates/gameitem.htm")
    layout: require("text!apps/top/list/templates/layout.htm")
    topgame: require("text!apps/top/list/templates/topgame.htm")