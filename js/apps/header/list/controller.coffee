# header list controller
define ["msgbus","apps/header/list/views", "controller/_base"], (msgBus, Views, AppController) ->
    appChannel = msgBus.appChannel
    class Controller extends AppController
        initialize: ->
            layout = new Views.Layout

            layout.render()