define ["backbone", "msgbus",], (Backbone, msgBus ) ->
    dataChannel = msgBus.dataChannel

    class Author extends Backbone.Model
        defaults:
            fullName: "Jack Killilea"
            twitter: "https://www.twitter.com/jack_killilea"
            github: "https://www.github.com/xjackk"

    API =
        getAuthor: ->
            new Author

    dataChannel.reply "get:authorModel:info", ->
        API.getAuthor()