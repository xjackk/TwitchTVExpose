# list header views
define ['views/_base','apps/header/list/templates'], (AppView, Templates) ->

    class   _itemview extends AppView.ItemView
        template: _.template(Templates.item)
        tagName: "li"

    LoginView: class Loginview extends AppView.ItemView
        template: _.template(Templates.login)
        el: "#login"

    HeaderView: class HeaderList extends AppView.CompositeView
        template: _.template(Templates.header)
        itemView: _itemview
        itemViewContainer: "ul"

    Layout:     class HeaderLayout extends AppView.Layout
        template: _.template(Templates.layout)
        regions:
            listRegion: "#list-region"
