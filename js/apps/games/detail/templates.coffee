# modular template loading
define (require) ->
    gamedetail: require("text!apps/games/detail/templates/gamedetail.htm")
    layout: require("text!apps/games/detail/templates/layout.htm")