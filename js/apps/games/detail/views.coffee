define ['apps/games/detail/templates', 'marionette', 'msgbus'], (Templates, Mn, msgBus) ->

    Detail: class GameDetail extends Mn.View
        template: _.template(Templates.gamedetail)
        className: "col-xs-12"
        #triggers:
        #    "click" : "game:item:clicked"


    Layout: class GamesLayout extends Mn.View
        template: _.template(Templates.layout)
        regions:
            gameRegion:  "#game-region"
            streamRegion:   "#stream-region"