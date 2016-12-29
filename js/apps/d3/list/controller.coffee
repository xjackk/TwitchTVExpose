define ["msgbus", "apps/d3/list/views", "controller/_base"], (MsgBus, Views, AppController) ->
    appChannel = MsgBus.appChannel

    class Controller extends AppController
        
        initialize:(options)->
            region = appChannel.request "default:region"
            layout = new Views.Layout
            region.show layout


            