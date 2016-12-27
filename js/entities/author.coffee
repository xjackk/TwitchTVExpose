define ["backbone", "msgbus",], (Backbone, msgBus ) ->
    appChannel = msgBus.appChannel


    class Author extends Backbone.Model
        defaults:
            fullName: "Jack Killilea"
            twitter: "https://www.twitter.com/jack_killilea"
            github: "https://www.github.com/xjackk"


    author = new Author