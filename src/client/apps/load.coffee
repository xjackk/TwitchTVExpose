# preload all apps here
define [    
    #"apps/about/app"
    #"apps/games/app"
    #"apps/d3/app"
    #"apps/streams/app"
    "apps/footer/app"
    "apps/header/app"
 ], ->
    # so, above each module/app that derives from base:app gets passed in the args
    args = Array.prototype.slice.call(arguments)
    startEvents: args.map (app) ->
        app.startEvent # each module gets a startEvent property
 

