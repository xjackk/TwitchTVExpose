# modular template loading
define (require) ->
    gameitem:       require "text!apps/games/list/templates/gameitem.htm"
    layout:         require "text!apps/games/list/templates/layout.htm"
    gameslist:      require "text!apps/games/list/templates/gameslist.htm"
    gamesbubble:    require "text!apps/games/list/templates/gamesbubble.htm"