# static header entities
define ["backbone","msgbus"], (Backbone, msgBus ) ->
    dataChannel = msgBus.dataChannel

    menu = new Backbone.Collection [
        (name: "Games", url: "#games", title: "Live Games", cssClass: "glyphicon glyphicon-hdd" )
        (name: "D3", url: "#d3", title: "Sample D3 visualization", cssClass: "glyphicon glyphicon-list")
        (name: "About", url: "#about", title: "Learn about responsive Twitch-TV", cssClass: "glyphicon glyphicon-align-justify")]
 

    API =
        getHeaders:->
            menu

    dataChannel.reply "header:entities", ->
        API.getHeaders()
