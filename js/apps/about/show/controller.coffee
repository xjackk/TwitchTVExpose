define ["marionette", "msgbus", "apps/about/show/views", "controller/_base"], (Mn, msgBus, Views, AppController) ->
    appChannel = msgBus.appChannel


    class Controller extends AppController
        initialize:(options={})->

            data=
                bookEntities:   appChannel.request "reference:entities"
                ossEntities:    appChannel.request "oss:entities"

            layout = @getLayoutView data

            @show layout,
                loading:
                    entities: [data.bookEntities, data.ossEntities]

        getLayoutView: (options)->
            new Views.LayoutView options


