define ["backbone", "msgbus",], (Backbone, msgBus ) ->

    class Author extends Backbone.Model
        defaults:
            fullName: "Jack Killilea"
            twitter: "https://www.twitter.com/jack_killilea"
            github: "https://www.github.com/xjackk"

    API =
        getAuthor: ->
            new Author

    msgBus.reqres.setHandler "get:authorModel:info", ->
        API.getAuthor()