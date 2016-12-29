define ["apps/playa/show/views", "marionette","msgbus"], (Views, Mn, msgBus) ->
    appChannel = msgBus.appChannel

    class Controller extends Mn.Object
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
