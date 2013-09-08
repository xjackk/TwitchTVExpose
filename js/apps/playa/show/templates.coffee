# modular template loading
define (require) ->
    player: require("text!apps/playa/show/templates/player.htm")
    user: require("text!apps/playa/show/templates/user.htm")
    layout: require("text!apps/playa/show/templates/layout.htm")
