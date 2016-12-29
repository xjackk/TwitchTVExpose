define ["msgbus", "apps/d3/list/views", "marionette"], (MsgBus, Views, Mn) ->
    appChannel = MsgBus.appChannel

    class Controller extends Mn.Object
        
        initialize:(options)->
            region = appChannel.request "default:region"
            layout = new Views.Layout
            region.show layout


            