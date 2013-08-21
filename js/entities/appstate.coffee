define ["entities/_backbone", "msgbus"], (_Backbone, msgBus ) ->

    class AppState extends _Backbone.Model
        defaults:
            clientId: "hqxyqc9bf41e6grm6txrsdcwncoxavz"
            accessToken: false
            loginStatus: false

    appState = new AppState

    API =
        getAppState: ->
            appState

    msgBus.reqres.setHandler "get:current:appstate", ->
        API.getAppState()

    msgBus.reqres.setHandler "get:current:token", ->
        appState.get "accessToken"
