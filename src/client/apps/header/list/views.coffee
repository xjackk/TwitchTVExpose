# list header views
define ['views/_base', 'apps/header/list/templates'], (BaseView, Templates) ->
    console.log BaseView

    class _itemview extends BaseView.ItemView
        template: _.template(Templates.item)
        tagName: "li"

    LoginView: class _Loginview extends BaseView.ItemView
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
