define ['msgbus', 'apps/games/list/templates', 'marionette', 'views/bubble'], (msgBus, Templates, Mn, BubbleChart) ->
    appChannel = msgBus.appChannel

    class GameItem extends Mn.View
        template: _.template(Templates.gameitem)
        tagName: "li"
        className: "col-md-2 col-sm-4 col-xs-12 game"
        triggers:
            "click" : "game:item:clicked"


    GameGridView: class TopGameList extends Mn.CollectionView
        childView: GameItem
        tagName: "ul"
        className: "list-inline"

        onChildviewGameItemClicked: (cv)->
            console.log cv
            appChannel.trigger "app:game:detail", cv.model

        #childViewEvents:
        #    'game:item:clicked': (gameItem)->
        #        appChannel.trigger "app:game:detail", gameItem.model



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
            btnMore:    "button.more"
        
        triggers:
            "click @ui.btnBubble":  "show:bubble"
            "click @ui.btnGrid":    "show:grid"
            "click @ui.btnMore":    "more:games"


        onRender:->
            @showChildView "topGameList", new TopGameList
                collection: @collection

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