# footer_app controller
define ["msgbus","apps/footer/show/views", "marionette", 'entities/author'], (msgBus, View, Mn, Author) ->
    appChannel = msgBus.appChannel

    class Controller extends Mn.Object
        initialize:->
            options =
                model: Author

            footerView = new View.FooterView options
            footerView.render()