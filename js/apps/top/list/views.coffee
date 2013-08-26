# list currency views
define ['apps/top/list/templates', 'views/_base', 'd3'], (Templates, AppView) ->

    class GameItem extends AppView.ItemView
        template: _.template(Templates.gameitem)

    TopGameList: class TopGameList extends AppView.CompositeView
        template: _.template(Templates.topgame)
        itemView: GameItem
        itemViewContainer: "#items"

    Layout: class DataVisLayout extends AppView.Layout
        template: _.template(Templates.layout)
        regions:
            topGameRegion: "#gametop-region"