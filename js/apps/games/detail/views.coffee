define ['marionette', 'msgbus', 'apps/games/detail/templates', ], (Mn, msgBus, Templates ) ->
    appChannel = msgBus.appChannel

    class StreamItem extends Mn.View
        template: _.template(Templates.streamitem)
        tagName: "li"
        className: "col-md-6 col-xs-12 streamitem"
        triggers:
            "click" : "stream:item:clicked"


    class StreamListView extends Mn.CollectionView
        childView: StreamItem
        tagName: "ul"
        className: "list-inline scrollable-container scrollable-inner"

        ui:
            scroll:             ".scrollable-inner"
            scrollContainer:    ".scrollable-container"

        events:
            "scroll": "checkScroll"

        checkScroll: (e) =>
            console.log "scroll", e

            virtualHeight = @ui.scroll.height()
            margin = .07 * virtualHeight #7%
            scrollTop = @ui.scrollContainer.scrollTop() + @ui.scrollContainer.height()
            @trigger "scroll:more" if (scrollTop+margin) >= virtualHeight


        onChildviewStreamItemClicked: (cv)->
            console.log cv.model
            console.log @$el
            appChannel.trigger "app:playa:show", cv.model



    class GameDetail extends Mn.View
        template: _.template(Templates.gamedetail)
        className: "col-xs-12"
        #model: @model


    Layout: class GamesLayout extends Mn.View
        template: _.template(Templates.layout)
        regions:
            gameRegion:     "#game-region"
            streamRegion:
                el: "ul"
                replaceElement: true

        ui:
            scroll:             ".scrollable-inner"
            scrollContainer:    ".scrollable-container"

        events:
            "scroll": "checkScroll"

        checkScroll: (e) =>
            console.log "scroll",e

            virtualHeight = @ui.scroll.height()
            margin = .07 * virtualHeight #7%
            scrollTop = @ui.scrollContainer.scrollTop() + @ui.scrollContainer.height()
            @trigger "scroll:more" if (scrollTop+margin) >= virtualHeight
                

        onRender: ()->
            #console.log "onRender: 1:", a
            #test = @getOption "streams"
            #test2 = @getOption "gameModel"
            #console.log "streams?:", test
            #console.log "gameModel?:", test2

            @showChildView "gameRegion", new GameDetail
                model: @getOption("gameModel")

            @showChildView "streamRegion", new StreamListView
                collection: @getOption("streams")


