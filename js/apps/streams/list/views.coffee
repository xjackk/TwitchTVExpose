# derive from base views and use templates for this app
define ['views/_base', 'apps/streams/list/templates'], (AppViews, Templates) ->

    class StreamItem extends AppViews.ItemView
        template: _.template(Templates.streamitem)
        triggers:
            "click" : "stream:item:clicked"

    ListView: class StreamList extends AppViews.CompositeView
        template: _.template(Templates.streams)
        itemView: StreamItem
        itemViewContainer: "#items"
