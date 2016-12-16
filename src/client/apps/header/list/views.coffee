# list header views
define ['views/_base', 'apps/header/list/templates' ], (AppView, Templates) ->

    class headerItem extends AppView.ItemView
        template: _.template(Templates.item)
        tagName: "li"

    Login_View: class Loginview extends AppView.ItemView
        template: _.template(Templates.login)
        el: "#login"

    HeaderView: class HeaderList extends AppView.CompositeView
        template: _.template(Templates.header)
        itemView: headerItem
        itemViewContainer: "ul"

    LayoutView: class HeaderLayout extends AppView.Layout
        template: _.template(Templates.layout)
        regions:
            listRegion: "#list-region"
#