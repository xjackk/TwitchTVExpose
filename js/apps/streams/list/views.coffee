# derive from base views and use templates for this app
define ['msgbus', 'marionette', 'apps/streams/list/templates'], (msgBus, Mn, Templates) ->
    appChannel = msgBus.appChannel

    class StreamItem extends Mn.View
        template: _.template(Templates.streamitem)
        tagName: "li"
        className: "col-md-6 col-xs-12 streamitem"
        triggers:
            "click" : "stream:item:clicked"

    class StreamListView extends Mn.CollectonView
        childView: StreamItem
        tagName: "ul"
        className: "list-inline"

        onChildviewStreamItemClicked: (cv)->
            appChannel.trigger "app:playa:show", cv.model



    Layout: class StreamLayout extends Mn.View
        template: _.template(Templates.streams)
        
        regions:
            streams:
                el: "ul"
                replaceElement: true

        events:
            "scroll": "checkScroll"

        checkScroll: (e) =>
            virtualHeight = @$("> div").height()
            scrollTop = @$el.scrollTop() + @$el.height()
            margin = 200
            #console.log "virtualHeight:", virtualHeight, "scrollTop:", scrollTop, "elHeight", @$el.height()
            if ((scrollTop + margin) >= virtualHeight)
                #console.log "scroll:more"
                @trigger "scroll:more"

        onRender: ->
            @showChildView "streams", new StreamListView
                collection: @collection