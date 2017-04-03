define ["entities/_backbone", "msgbus"], (_Backbone, msgBus ) ->

    class AppState extends _Backbone.Model
        defaults:
            #clientId: "hqxyqc9bf41e6grm6txrsdcwncoxavz" # this is the JackApp clientId
            clientId: "x77jaxed6gmro98hgmv3poxrzf9dty"  # newly created to point back to http://localhost:3000
            accessToken: "n/a"
            loginStatus: false
            uri: "http://localhost:3000" #"http://twitchtvexpose.herokuapp.com"


    API =
        getAppState: ->
            appState

    msgBus.reqres.setHandler "get:current:appstate", ->
        API.getAppState()

    msgBus.reqres.setHandler "get:current:token", ->
        appState.get "accessToken"

    appState = new AppState
