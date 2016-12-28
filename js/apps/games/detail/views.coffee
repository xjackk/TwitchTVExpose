define ['marionette', 'msgbus', 'apps/games/detail/templates', ], (Mn, msgBus, Templates ) ->
    appChannel = msgBus.appChannel

    Detail: class GameDetail extends Mn.View
        template: _.template(Templates.gamedetail)
        className: "col-xs-12"
        #triggers:
        #    "click" : "game:item:clicked"


    Layout: class GamesLayout extends Mn.View
        template: _.template(Templates.layout)
        regions:
            gameRegion:     "#game-region"
            streamRegion:   "#stream-region"

        onDomRefresh: ->
            model =  @getOption "gameModel"
            region = @getRegion 'streamRegion'
            console.log "REGION", region

            @showChildView "gameRegion", new GameDetail
                model: model

            #appChannel.trigger "app:streams:list", @getRegion('streamRegion'), model.get("game").name
