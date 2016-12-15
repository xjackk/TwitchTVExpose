# list header views
define ['marionette', 'apps/header/list/templates' ], (Marionette, Templates) ->
    console.log "BASE VIEW IS:  ", Marionette

    class _itemview extends Marionette.ItemView
        template: _.template(Templates.item)
        tagName: "li"

    Login_View: class _Loginview extends Marionette.ItemView
        template: _.template(Templates.login)
        el: "#login"

    HeaderView: class _HeaderList extends Marionette.CompositeView
        template: _.template(Templates.header)
        itemView: _itemview
        itemViewContainer: "ul"

    LayoutView:     class _HeaderLayout extends Marionette.Layout
        template: _.template(Templates.layout)
        regions:
            listRegion: "#list-region"
