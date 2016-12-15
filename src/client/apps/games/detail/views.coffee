define ['marionette', 'apps/games/detail/templates' ], (Marionette, Templates) ->

    Detail: class GameDetail extends Marionette.ItemView
        template: _.template(Templates.gamedetail)
        className: "col-xs-12"
        #triggers:
        #    "click" : "game:item:clicked"


    Layout: class GamesLayout extends Marionette.Layout
        template: _.template(Templates.layout)
        regions:
            gameRegion:  "#game-region"
            streamRegion:   "#stream-region"