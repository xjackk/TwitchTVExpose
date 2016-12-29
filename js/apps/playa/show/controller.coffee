define ["apps/playa/show/views", "controller/_base","msgbus"], (Views, AppController, msgBus) ->
    appChannel = msgBus.appChannel

    class Controller extends AppController
        initialize:(options={})->
            {channel, model} = options
            mainRegion = appChannel.request "default:region"

            model = appChannel.request "search:stream:model", channel if model is undefined
            appChannel.trigger "when:fetched", model, =>
                layout = @getLayoutView model

                mainRegion.show layout

        getLayoutView: (model)->
            new Views.Layout
                model: model
