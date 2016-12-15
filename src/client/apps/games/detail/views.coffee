define ['views/_base', 'apps/games/detail/templates' ], (AppView, Templates) ->

    Detail: class GameDetail extends AppView.ItemView
        template: _.template(Templates.gamedetail)
        className: "col-xs-12"
        #triggers:
        #    "click" : "game:item:clicked"


    Layout: class GamesLayout extends AppView.Layout
        template: _.template(Templates.layout)
        regions:
            gameRegion:  "#game-region"
            streamRegion:   "#stream-region"