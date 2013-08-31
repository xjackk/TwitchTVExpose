# static header entities
define ["backbone","msgbus"], (Backbone, msgBus ) ->
    
    API =
        getHeaders:->
            new Backbone.Collection [
                    (name: "Top", url: "#top", title: "Top Games")
                    (name: "D3", url: "#d3", title: "Sample D3 visualization")
                    (name: "About", url: "#about", title: "Learn about responsive Twitch-TV")]

    msgBus.reqres.setHandler "header:entities", ->
        API.getHeaders()
