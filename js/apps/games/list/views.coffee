define ['apps/games/list/templates', 'marionette', 'views/bubble'], (Templates, Mn, BubbleChart) ->

    class GameItem extends Mn.View
        template: _.template(Templates.gameitem)
        tagName: "li"
        className: "col-md-2 col-sm-4 col-xs-12 game"
        triggers:
            "click" : "game:item:clicked"

    class TopGameList extends Mn.CollectionView
        #template: _.template(Templates.gameslist)
        tagName: "ul"
        childView: GameItem
        #id: "gamelist"
        #itemViewContainer: "#gameitems"

        events:
            "scroll": "checkScroll"

        checkScroll: (e) =>
            virtualHeight = @$("> div").height()    #important this div must have css height: 100% to enable calculattion of virtual height scroll
            scrollTop = @$el.scrollTop() + @$el.height()
            margin = 200
            #console.log "virtualHeight:", virtualHeight, "scrollTop:", scrollTop, "elHeight", @$el.height()
            if ((scrollTop + margin) >= virtualHeight)
                @trigger "scroll:more"

    GamesBubbleView: class GamesBubbleView extends Mn.View
        template: _.template(Templates.gamesbubble)
        id: "gamesbubble"

        onDomRefresh: ->
            $width 	= @$el.outerWidth(true)
            $height = Math.floor $width * 10 / 16
            @chart = new BubbleChart @collection, @el, $width, $height
            @chart.start()
            @chart.display()

    Layout: class GamesLayout extends Mn.View
        template: _.template(Templates.layout)
        regions:
            topGameList:  "ul#topgames"

        ui:
            btnBubble:  "button.bubble"
            btnGrid:    "button.grid"
        
        triggers:
            "click @ui.btnBubble": "show:bubble"
            "click @ui.btnGrid": "show"

        onRender:->
            @showChildView "topGameList", new TopGameList
                collection: @collection

        #events:
        #        "click button.bubble":    "bubble"
        #        "click button.grid":      "grid"

        #bubble:->
        #    @trigger "show:bubble"

        #grid:->
        #    @trigger "show"