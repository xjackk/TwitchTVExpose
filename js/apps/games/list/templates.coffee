# modular template loading
define (require) ->
    gameitem: require("text!apps/games/list/templates/gameitem.htm")
    layout: require("text!apps/games/list/templates/layout.htm")
    topgame: require("text!apps/games/list/templates/topgame.htm")
    hero: require("text!apps/games/list/templates/hero.htm")
