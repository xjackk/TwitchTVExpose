# footer_app controller
define ["msgbus","apps/footer/show/views", "controller/_base"], (msgBus, Views, AppController) ->
    dataChannel = msgBus.dataChannel
    console.log "apps/footer/show/views", Views

    temp =dataChannel.request "get:authorModel:info"
    console.log "author info", temp

    class Controller extends AppController
        initialize:->
            author = dataChannel.request "get:authorModel:info"
            footerView = @getFooterView author
            @show footerView

        getFooterView: (model) ->
            new Views.ItemView
                model: model