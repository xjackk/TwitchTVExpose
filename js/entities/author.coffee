define ["entities/_backbone", "msgbus",], (_Backbone, msgBus ) ->

    class Author extends _Backbone.Model
        defaults:
            fullName: "Jack Killilea"
            twitter: "https://www.twitter.com/jack_killilea"
            github: "https://www.github.com/xjackk"

    API =
        getAuthor: ->
            new Author

    msgBus.reqres.setHandler "get:authorModel:info", ->
        API.getAuthor()