# static entities
define ["backbone","msgbus"], (Backbone, msgBus ) ->
    appChannel = msgBus.appChannel

    API =
        getReferences:->
            new Backbone.Collection [
                    (type: "book", title: "Little Book on Coffeescript", author: "Alex MacCaw", url: "books.google.com/books?isbn=1449325548")
                    (type: "book", title: "Javascript The Good Parts", author: "Douglas Crockford", url: "books.google.com/books?isbn=0596554877")
                    (type: "book", title: "High Performance Javascript", author: "Nicholas C. Zakas", url:"books.google.com/books?isbn=1449388744")
                    (type: "book", title: "jQuery Cookbook", author: "jQuery Community Experts", url:"books.google.com/books?isbn=1449383017")
                    (type: "book", title: "HTML and CSS: Design and Build Websites", author:"Jon Duckett", url:"books.google.com/books?isbn=1118206916")
                    (type: "book", title: "Interactive Data Visualation for the Web", author:"Scott Murray", url:"books.google.com/books?isbn=1449340253")
                    (type: "book", title: "Developing Backbone.js Applications", author:"Addy Osmani", url:"books.google.com/books?isbn=1449328555")
                    (type: "book", title: "Bootstrap", author:"Jake Spurlock", url:"books.google.com/books?isbn=1449344593")
                    (type: "video", title: "Client Side Development", author:"Brian Mann", url:"vimeo.com/58787395")
                    (type: "video", title: "Tenets of Backbone JS", author:"Brian Mann", url:"vimeo.com/58787396")
                    (type: "video", title: "Marionette JS", author:"Brian Mann", url:"vimeo.com/58797363")
                    (type: "video", title: "Application Infrastructure", author:"Brian Mann", url: "backbonerails.fetchapp.com/sell/aezoosaw/ppc")
                    (type: "video", title: "Getting Up and Running - Part 1", author:"Brian Mann", url:"backbonerails.fetchapp.com/sell/siyeebee/ppc")
                    (type: "video", title: "Getting Up and Running - Part 2", author:"Brian Mann", url:"backbonerails.fetchapp.com/sell/ferechie/ppc")
                    (type: "video", title: "Building a Real Application: Planet Express", author:"Brian Mann", url:"backbonerails.fetchapp.com/sell/ichangei/ppc")
                    (type: "video", title: "Screencast: Loading Views", author:"Brian Mann", url:"www.backbonerails.com/screencasts/loading-views")
                    (type: "book", title: "Creating Animated Bubble Charts in D3", author:"Jim Vallandingham", url:"vallandingham.me/bubble_charts_in_d3.html")
                    ]

    appChannel.reply "reference:entities", ->
        API.getReferences()
