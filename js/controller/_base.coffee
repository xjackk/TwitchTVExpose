define ["marionette", "msgbus"], (Marionette, msgBus) ->
    appChannel = msgBus.appChannel

    class AppController extends Marionette.Object
        constructor: (options = {}) ->
            @region = options.region or appChannel.request "default:region"
            super options

        close: (args...) ->
            delete @region
            delete @options
            super args

        show: (view, options = {}) ->
            _.defaults options,
                loading: false
                region: @region

            @_setMainView view
            @_manageView view, options

        _setMainView: (view) ->
            return if @_mainView
            @_mainView = view
            @listenTo view, "close", @close

        _manageView: (view, options) ->
            if options.loading
                appChannel.trigger "show:loading", view, options
            else
                options.region?.show view
