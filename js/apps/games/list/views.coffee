define ['apps/games/list/templates', 'views/_base'], (Templates, AppView) ->

    class GameItem extends AppView.ItemView
        template: _.template(Templates.gameitem)
        triggers:
            "click" : "game:item:clicked"

    TopGameList: class TopGameList extends AppView.CompositeView
        template: _.template(Templates.topgame)
        itemView: GameItem
        itemViewContainer: "#items"

    Hero: class Hero extends AppView.ItemView
        template: _.template(Templates.hero)

    Layout: class GamesLayout extends AppView.Layout
        template: _.template(Templates.layout)
        regions:
            gameRegion:  "#game-region"
            streamRegion:   "#stream-region"