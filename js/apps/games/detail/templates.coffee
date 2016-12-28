# modular template loading
define (require) ->
    gamedetail:     require "text!apps/games/detail/templates/gamedetail.htm"
    streamitem:     require "text!apps/games/detail/templates/streamitem.htm"
    layout:         require "text!apps/games/detail/templates/layout.htm"