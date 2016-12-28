# footer_app controller
define ["msgbus","apps/footer/show/views", "controller/_base", 'entities/author'], (msgBus, View, AppController, Author) ->
    appChannel = msgBus.appChannel

    class Controller extends AppController
        initialize:->
            options =
                model: Author

            footerView = new View.FooterView options
            footerView.render()