# derive from base views and use templates for this app
define ['views/_base', 'apps/streams/list/templates'], (AppView, Templates) ->

    class StreamItem extends AppView.ItemView
        template: _.template(Templates.streamitem)
        tagName: "li"
        className: "col-md-6 col-xs-12 streamitem"
        triggers:
            "click" : "stream:item:clicked"

    ListView: class StreamList extends AppView.CompositeView
        template: _.template(Templates.streams)
        itemView: StreamItem
        itemViewContainer: "#items"
        id: "streamlist"

        events:
            "scroll": "checkScroll"

        checkScroll: (e) =>
            virtualHeight = @$("> div").height()
            scrollTop = @$el.scrollTop() + @$el.height()
            margin = 200
            #console.log "virtualHeight:", virtualHeight, "scrollTop:", scrollTop, "elHeight", @$el.height()
            if ((scrollTop + margin) >= virtualHeight)
                @trigger "scroll:more"
#