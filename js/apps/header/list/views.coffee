# list header views
define ["marionette", 'apps/header/list/templates', 'entities/header', 'entities/appstate' ], (Mn, Templates, menuCollection, appState) ->
    class MenuView extends Mn.View
        template: _.template(Templates.item)
        tagName: "li"

    class LoginView extends Mn.View
        template: _.template(Templates.login)
        el: "#login"


    class MenuItemsView extends Mn.CollectionView
        tagName: "ul"
        className: "nav navbar-nav"
        childView: MenuView


    Layout: class HeaderLayout extends Mn.View
        el: "#header-region"
        template: _.template(Templates.header)
        regions:
            menuRegion: 
                el: "ul"
                replaceElement: true

            loginRegion: 
                el: "#login"
                replaceElement: true

        onRender: ->
            console.log appState
            console.log menuCollection

            @showChildView "menuRegion", new MenuItemsView
                collection: menuCollection
            @showChildView "loginRegion", new LoginView
                model: appState
