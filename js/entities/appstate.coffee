define ["backbone"], (Backbone) ->

    class AppState extends Backbone.Model
        defaults:
            #clientId: "hqxyqc9bf41e6grm6txrsdcwncoxavz" # this is the JackApp clientId
            clientId: "x77jaxed6gmro98hgmv3poxrzf9dty"  # newly created to point back to http://localhost:3000
            accessToken: "n/a"
            loginStatus: false
            uri: "http://localhost:3000" #"http://twitchtvexpose.herokuapp.com"


    API =
        getAppState: ->
            appState

    appState = new AppState
