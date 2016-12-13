# footer_app controller
define ["msgbus","apps/footer/show/views", "controller/_base"], (msgBus, View, AppController) ->
    channel = msgBus.appChannel

    class Controller extends AppController
        initialize:->
            author = channel.request "get:authorModel:info"
            footerView = @getFooterView author
            @show footerView

        getFooterView: (model) ->
            new View.ItemView
                model: model