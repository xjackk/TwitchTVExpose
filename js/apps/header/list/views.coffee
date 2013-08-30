# list header views
define ['apps/header/list/templates', 'views/_base'], (Templates, AppView) ->

    class _itemview extends AppView.ItemView
        template: _.template(Templates.item)
        tagName: "li"

    LoginView: class Loginview extends AppView.ItemView
        template: _.template(Templates.login)
        el: "#login"

    HeaderView: class ListHeaders extends AppView.CompositeView
        template: _.template(Templates.header)
        itemView: _itemview
        itemViewContainer: "ul"

    Layout: class Header extends AppView.Layout
        template: _.template(Templates.layout)
        regions:
            listRegion: "#list-region"
