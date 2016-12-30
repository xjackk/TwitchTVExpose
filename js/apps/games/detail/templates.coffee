# modular template loading
define (require) ->
    gamedetail:     require "text!apps/games/detail/templates/gamedetail.htm"
    streamitem:     require "text!apps/games/detail/templates/streamitem.htm"
    streamsummary:  require "text!apps/games/detail/templates/streamsummary.htm"
    layout:         require "text!apps/games/detail/templates/layout.htm"