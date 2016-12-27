# static header entities
define ["backbone","msgbus"], (Backbone, msgBus ) ->
    menu = new Backbone.Collection([
        (id: 1, name: "Games", url: "#games", title: "Live Games", cssClass: "glyphicon glyphicon-hdd" )
        (id: 2, name: "D3", url: "#d3", title: "Sample D3 visualization", cssClass: "glyphicon glyphicon-list")
        (id: 3, name: "About", url: "#about", title: "Learn about responsive Twitch-TV", cssClass: "glyphicon glyphicon-align-justify")])


    menu
