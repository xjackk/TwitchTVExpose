define ['apps/games/list/templates', 'views/_base', 'msgbus'], (Templates, AppView, msgBus) ->

    class GameItem extends AppView.ItemView
        template: _.template(Templates.gameitem)
        tagName: "li"
        className: "col-lg-3 col-md-4 col-sm-6 col-xs-12 game"
        triggers:
            "click" : "game:item:clicked"

    TopGameList: class TopGameList extends AppView.CompositeView
        template: _.template(Templates.gamelist)
        itemView: GameItem
        id: "gamelist"
        itemViewContainer: "#gameitems"

        events:
            "scroll": "checkScroll"

        onClose:->
            console.log "onClose called"

        checkScroll: (e) =>
            virtualHeight = @$("> div").height()          #important this div must have css 100% height so we can calculate the virtual height scroll
            scrollTop = @$el.scrollTop() + @$el.height()
            margin = 200
            console.log "virtualHeight:", virtualHeight, "scrollTop:", scrollTop, "elHeight", @$el.height()
            if ((scrollTop + margin) >= virtualHeight)
                @trigger "scroll:more"

    Hero: class Hero extends AppView.ItemView
        template: _.template(Templates.hero)

    Layout: class GamesLayout extends AppView.Layout
        template: _.template(Templates.layout)
        regions:
            gameRegion:  "#game-region"
            streamRegion:   "#stream-region"