define ['views/_base', 'views/bubble', 'apps/games/list/templates' ], (AppView, BubbleChart, Templates) ->

    class GameItem extends AppView.ItemView
        template: _.template(Templates.gameitem)
        tagName: "li"
        className: "col-md-2 col-sm-4 col-xs-12 game"
        triggers:
            "click" : "game:item:clicked"

    TopGameList: class TopGameList extends AppView.CompositeView
        template: _.template(Templates.gameslist)
        itemView: GameItem
        id: "gamelist"
        itemViewContainer: "#gameitems"

        events:
            "scroll": "checkScroll"

        checkScroll: (e) =>
            virtualHeight = @$("> div").height()    #important this div must have css height: 100% to enable calculattion of virtual height scroll
            scrollTop = @$el.scrollTop() + @$el.height()
            margin = 200
            #console.log "virtualHeight:", virtualHeight, "scrollTop:", scrollTop, "elHeight", @$el.height()
            if ((scrollTop + margin) >= virtualHeight)
                @trigger "scroll:more"

    GamesBubbleView: class GamesBubbleView extends AppView.ItemView
        template: _.template(Templates.gamesbubble)
        id: "gamesbubble"

        onShow: ->
            $width 	= @$el.outerWidth(false)
            $height = Math.floor $width * 9 / 16
            @chart = new BubbleChart @collection, @el, $width, $height
            @chart.start()
            @chart.display()

    Layout: class GamesLayout extends AppView.Layout
        template: _.template(Templates.layout)
        regions:
            gameRegion:  "#game-region"

        events:
                "click .bubble":    "bubble"
                "click .grid":      "grid"

        bubble:->
            @trigger "show:bubble"

        grid:->
            @trigger "show"