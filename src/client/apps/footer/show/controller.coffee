# footer_app controller
define ["msgbus","apps/footer/show/views", "controller/_base"], (msgBus, Views, AppController) ->
    channel = msgBus.appChannel
    console.log "apps/footer/show/views", Views

    class Controller extends AppController
        initialize:->
            author = channel.request "get:authorModel:info"
            footerView = @getFooterView author
            @show footerView

        getFooterView: (model) ->
            new Views.ItemView
                model: model