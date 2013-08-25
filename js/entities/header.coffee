# static header entities
define ["backbone","msgbus"], (Backbone, msgBus ) ->
    
    API =
        getHeaders:->
            new Backbone.Collection [
                    (name: "top", url: "#top", title: "Top Games")
                    (name: "d3", url: "#d3", title: "Jack's App")
                    (name: "About", url: "#about", title: "About Jack's App")]

    msgBus.reqres.setHandler "header:entities", ->
        API.getHeaders()
