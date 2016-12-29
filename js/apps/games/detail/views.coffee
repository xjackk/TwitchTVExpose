define ['marionette', 'msgbus', 'apps/games/detail/templates', 'slimscroll' ], (Mn, msgBus, Templates ) ->
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
        className: "list-inline scrollable-inner"

        ui:
            scroll:             ".scrollable-inner"
            #scrollContainer:    ".scrollable-container"

        events:
            "scroll": "checkScroll"

        checkScroll: (e) =>
            console.log "scroll", e

            virtualHeight = @ui.scroll.height()
            margin = .07 * virtualHeight #7%
            scrollTop = @ui.scrollContainer.scrollTop() + @ui.scrollContainer.height()
            @trigger "scroll:more" if (scrollTop+margin) >= virtualHeight


        onChildviewStreamItemClicked: (cv)->
            appChannel.trigger "app:playa:show", cv.model



    class GameDetail extends Mn.View
        template: _.template(Templates.gamedetail)
        className: "col-xs-12"


    Layout: class GamesLayout extends Mn.View
        template: _.template(Templates.layout)
        regions:
            gameRegion:     "#game-region"
            streamRegion:
                el: "ul"
                replaceElement: true
                

        ui:
            scrollPanel: ".scrollable-container"

        onDomRefresh:->
            @ui.scrollPanel.slimScroll
                height: '800px'
                color: '#00f'
                wheelStep: 25
                size: 10
                distance: '1px'
                railVisible: true
                alwaysVisible:  true
            .bind 'slimscroll', (e,pos)->
                console.log "slimscroll @ #{pos}"
                appChannel.request "streams:fetchmore" if pos is 'top'


        onRender: ->
            @showChildView "gameRegion", new GameDetail
                model: @getOption("gameModel")

            @showChildView "streamRegion", new StreamListView
                collection: @getOption("streams")


