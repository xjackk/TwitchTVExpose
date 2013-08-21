# footer_app controller
define ["msgbus","apps/footer/show/views", "controller/_base"], (msgBus, View, AppController) ->

    class Controller extends AppController
        initialize:->
            author = msgBus.reqres.request "get:authorModel:info"
            console.log author
            footerView = @getFooterView author
            @show footerView


        getFooterView: (model) ->
            new View.ItemView
                model: model