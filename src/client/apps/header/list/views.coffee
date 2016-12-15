# list header views
define ['apps/header/list/templates', 'views/_base' ], (Templates, BaseView) ->
    console.log "BASE VIEW IS:  ", BaseView

    class _itemview extends BaseView.ItemView
        template: _.template(Templates.item)
        tagName: "li"

    Login_View: class _Loginview extends BaseView.ItemView
        template: _.template(Templates.login)
        el: "#login"

    HeaderView: class _HeaderList extends BaseView.CompositeView
        template: _.template(Templates.header)
        itemView: _itemview
        itemViewContainer: "ul"

    LayoutView:     class _HeaderLayout extends BaseView.Layout
        template: _.template(Templates.layout)
        regions:
            listRegion: "#list-region"
