define ['msgbus', 'apps/games/list/templates', 'marionette', 'views/bubble'], (msgBus, Templates, Mn, BubbleChart) ->
    appChannel = msgBus.appChannel

    class GameItem extends Mn.View
        template: _.template(Templates.gameitem)
        tagName: "li"
        className: "col-md-2 col-sm-4 col-xs-12 game"
        triggers:
            "click" : "game:item:clicked"


    TopGameList: class TopGameList extends Mn.CollectionView
        childView: GameItem
        tagName: "ul"
        className: "list-inline"
        childViewEvents:
            'game:item:clicked': (cv)->
                appChannel.trigger "app:game:detail", cv.model

        events:
            "scroll": "checkScroll"

        checkScroll: (e) =>
            console.log e
            virtualHeight = @$("> div").height()    #important this div must have css height: 100% to enable calculattion of virtual height scroll
            console.log virtualHeight

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
            topGameList:
                el:  "ul"
                replaceElement: true

        ui:
            btnBubble:  "button.bubble"
            btnGrid:    "button.grid"
        
        triggers:
            "click @ui.btnBubble":  "show:bubble"
            "click @ui.btnGrid":    "show:grid"

        onShowGrid:->
            console.log "showGrid!"
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