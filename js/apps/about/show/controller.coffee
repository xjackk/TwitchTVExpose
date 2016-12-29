define ["marionette", "msgbus", "apps/about/show/views", "controller/_base"], (Mn, msgBus, Views, AppController) ->
    appChannel = msgBus.appChannel

    class Controller extends AppController
        initialize:(options={})->
            region = appChannel.request "default:region"

            data=
                bookEntities:   appChannel.request "reference:entities"
                ossEntities:    appChannel.request "oss:entities"

            layout = @getLayoutView data

            region.show layout

        getLayoutView: (options)->
            new Views.LayoutView options


