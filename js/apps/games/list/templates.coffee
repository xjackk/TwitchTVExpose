# modular template loading
define (require) ->
    gameitem: require("text!apps/games/list/templates/gameitem.htm")
    layout: require("text!apps/games/list/templates/layout.htm")
    gamelist: require("text!apps/games/list/templates/gamelist.htm")
    hero: require("text!apps/games/list/templates/hero.htm")
