#TwitchTVExpose

A Single Page Client App implementing TwitchTV's API functionality. Using Backbone.Marionette, RequireJS, Coffeescript, and little D3.

**See [TwitchTVExpose](https://c9.io/xjackk/twitchtvexpose/workspace/index.htm) live, hosted on my Cloud9 site**

##Use Coffeescript##

Using Coffeescript has saved me writing much code as it compiles into JS. The Coffeescript syntax is a bit Python/Ruby esque, therefore attracting more and more attention recently.
I have switched over to using Coffeescript, and I really really do love it. It saves me syntax headaches, and is just a breeze to write in. I reccomend trying it.

~~~
$ npm install -g coffee-script
~~~

Keep in mind the watching directory and the output directory for compiling coffeescript to javascript. In this command, the **js** folder

~~~
$ coffee -o js/ -cw js/
~~~

<hr>

##Project Dependencies##

**Check out the [bower.json](https://github.com/xjackk/twitchtvexpose/blob/master/bower.json) file see this project's open-source dependencies**

With [BOWER](https://github.com/bower/bower), just one command and all of the project dependencies are installed:

~~~
$ bower install
~~~

As time marches on, update project dependencies with one command:

~~~
$ bower update
~~~

##Using Asyncronous Module Definition AMD  [RequireJS](http://requirejs.org)

This project uses a "Rails esque" approach. Keeping everything as modular as possible, and straying away from "spaghetti" codeing.

It follows an approach similar to Brian Mann's (he used Marionette.module implementation), however we're using RequireJS with Javascript patterns and a Rails convention.

<hr>


##Before we can start...

Before we can start with our AMD app, we need to make sure we are loading everything properly. In the [Js/apps](https://github.com/xjackk/TwitchTVExpose/tree/master/js/apps) folder, we have a [load.coffee](https://github.com/xjackk/TwitchTVExpose/blob/master/js/apps/load.coffee)
file dynamically loads all of our apps before they are started.

Anytime you add an app, we need to make sure we are adding it to this list. A small mistake I've made in the past that I hope you can avoid. (:

<h5>Config</h5>

In our [config load](https://github.com/xjackk/TwitchTVExpose/blob/master/js/config/load.coffee) file, we load dependencies also from other areas in our app. Make sure you load these, as they are important.

<hr>

<h5>Entities</h5>

Its important to know that most of the calls we are going to be making using our msgBus, is all going to our Entities.
In our entities, we have things such as our [appstate](), our [author info](), [header info](), and most importantly our [twitch.tv API calls]()

You will see frequent calls to things things via msgBus in the code.

<h5>How this all works. (Featuring `msgBus`)</h5>

You may be wondering how our msgBus works. The sole purpose of msgBus is that it allows us to set handlers to listen to, as well as execute these events.
Since we need to pull this info somehow, msgBus provides a way of listening to these events, or handlers that are set.

A perfect example of this is how we pull in the info for our `header:entities`

This decoupled code right here provides us with a way to dynamically pull in these entities into our header, without repeating ourselves. This keeps a very "modular" approach to building this app.

```
define ["backbone","msgbus"], (Backbone, msgBus ) ->

    API =
        getHeaders:->
            new Backbone.Collection [
                    (name: "Games", url: "#games", title: "Live Games", cssClass: "glyphicon glyphicon-hdd" )
                    (name: "D3", url: "#d3", title: "Sample D3 visualization", cssClass: "glyphicon glyphicon-list")
                    (name: "About", url: "#about", title: "Learn about responsive Twitch-TV", cssClass: "glyphicon glyphicon-align-justify")
                    ]

    msgBus.reqres.setHandler "header:entities", ->
        API.getHeaders()

```

<hr>

Starting our App
==============

[Main.coffee](https://github.com/xjackk/TwitchTVExpose/blob/master/js/main.coffee)

Here is our main file where we preload all of our dependencies. We like to keep a very "modular" approach to building this app, so this is where we load everything, then start the app.

Before I dive into each seperate app, I am going to introduce the initial "app" for this project. This is where We start all of our apps from event handlers.

[App.coffee](https://github.com/xjackk/TwitchTVExpose/blob/master/js/app.coffee)

In this big guy here, we add some "planning" for the rest of our project. We add our regions of the app, as well as the main routes and where we are starting.

Here are all of our handlers for our regions.

```
    app.on "initialize:before", (options={}) ->
        #console.log "init:before", options

    msgBus.reqres.setHandler "default:region",->
        app.mainRegion

    msgBus.reqres.setHandler "header:region", ->
        app.headerRegion

    msgBus.reqres.setHandler "footer:region", ->
        app.footerRegion

    msgBus.reqres.setHandler "main:region", ->
        app.mainRegion

    msgBus.commands.setHandler "register:instance", (instance, id) ->
        app.register instance, id

    msgBus.commands.setHandler "unregister:instance", (instance, id) ->
        app.unregister instance, id
```
After all this good stuff, we have our "Init after" where we are making a request to get our current Appstate. We will go into more detail later about this.
Under this you will see a a backbone.history set where we work some magic for Twitch's API. We will also be going into more detail later about this.

Lastly, we add some execute commands, to start all of our apps, all right in one place.

```

    app.addInitializer (options) ->
        #console.log "addinitializers"
        msgBus.commands.execute "start:header:app"
        msgBus.commands.execute "start:footer:app"
        msgBus.commands.execute "start:d3:app"
        msgBus.commands.execute "start:about:app"
        msgBus.commands.execute "start:games:app"
        msgBus.commands.execute "start:playa:app"

    app

```

The About App
==============

<h4>The about app starts with the [app coffee File](https://github.com/xjackk/TwitchTVExpose/blob/master/js/apps/about/app.coffee)</h4>

This file acts as the starting point of the app where we add a controller, and set an event handler to "start" off this app, as all these apps will be loaded beforehand, elsewhere.
We will go into more detail later about that.

<hr>

</h5>About Controller</h5>

[My Code for the About Controller](https://github.com/xjackk/TwitchTVExpose/blob/master/js/apps/about/show/controller.coffee)

The about Controller sets up sets up the three regions we will be adding data too.

+ About Region
+ Books Region
+ OSS Region


```
     aboutRegion:  ->
            view = @getAboutView()
            @layout.aboutRegion.show view

        bookRegion: (collection) ->
            view = @getBookView collection
            @layout.bookRegion.show view

        ossRegion: (collection) ->
            view = @getOssView collection
            @layout.ossRegion.show view

```

Also here in the controller we set up the getting of our three views.

```
        getOssView: (collection) ->
            new Views.Oss
                collection: collection

        getBookView: (collection) ->
            new Views.Books
                collection: collection

        getAboutView:  ->
            new Views.About

        getLayoutView: ->
            new Views.Layout
```

<h5>About Templates</h5>

[My Code for the About Templates](https://github.com/xjackk/TwitchTVExpose/blob/master/js/apps/about/show/templates.coffee)

Here we load our templates for our regions. Following our AMD approach.

```
define (require) ->
    about: require("text!apps/about/show/templates/about.htm")
    layout: require("text!apps/about/show/templates/layout.htm")
    books: require("text!apps/about/show/templates/books.htm")
    bookitem: require("text!apps/about/show/templates/bookitem.htm")
    oss: require("text!apps/about/show/templates/oss.htm")
    ossitem: require("text!apps/about/show/templates/ossitem.htm")

```

<hr>

<h5>About Views</h5>

[My Code for the About Views](https://github.com/xjackk/TwitchTVExpose/blob/master/js/apps/about/show/views.coffee)

Here is where the magic happens.

We create two classes here, one for our Book, and one for our OSS. These are two Itemviews. We simply pass through the template then associate a tag name with it.


```
class Book extends AppView.ItemView
        template: _.template(Templates.bookitem)
        tagName: "tr"

    class Oss extends AppView.ItemView
        template: _.template(Templates.ossitem)
        tagName: "tr"
```

After this, we pass those item views into our composite views with an `itemviewcontainer` like so.


```
   Books: class Books extends AppView.CompositeView
        template: _.template(Templates.books)
        itemView: Book
        itemViewContainer: "tbody"

    Oss: class Osslist extends AppView.CompositeView
        template: _.template(Templates.oss)
        itemView: Oss
        itemViewContainer: "tbody"
```


The Header App
==============

<h4>The header app starts with it's corrosponding [app](https://github.com/xjackk/TwitchTVExpose/blob/master/js/apps/header/app.coffee) file, which creates out list controller, and starts the app.</h4>

Once we have this, we can move on to our app itself. We begin to layout everything using [Bootstrap](getbootstrap.com) in our header.

[Header.htm](https://github.com/xjackk/TwitchTVExpose/blob/master/js/apps/header/list/templates/header.htm)

We only have one region for this header, and we lay it out, like so.

[Layout.htm](https://github.com/xjackk/TwitchTVExpose/blob/master/js/apps/header/list/templates/layout.htm)

Lastly, we need a login button, to authorize ourselves with Twitch TV's API.

[Twitch.TV Login](https://github.com/xjackk/TwitchTVExpose/blob/master/js/apps/header/list/templates/login.htm)

After we layout all of our html, we can move onto working with our controllers, templates, and views.

<hr>

<h5>Header Controller</h5>


Here we have our [Header Controller](https://github.com/xjackk/TwitchTVExpose/blob/master/js/apps/header/list/controller.coffee), where we start doing some work for our API's.


```

            links = msgBus.reqres.request "header:entities"
            @appstate = msgBus.reqres.request "get:current:appstate"
            #console.log @appstate
            @layout = @getLayoutView()

            # new appstate is now a property of the controller have the controller listen to the specific attribute
            # so from anywhere you can set the appstate's loginStatus to T/F and this button will toggle
            @listenTo @appstate, "change:loginStatus", (model, status) =>
                @loginView.close() if status is true
                @loginView.render() if status is false

            @listenTo @layout, "show", =>
                @listRegion links
                @loginView = @getLoginView @appstate
                @loginView.render()  #stick-it into the DOM

            @show @layout

```

We need to set up our msgbug requrests for getting our header and update our "appstate". Our new appstate is a property of our controller and we can listen
to specific events going on. In our case, we want to see if we are logged in, or not.

Our last line,`loginview.render()` will stick our loginview right into our DOM. Perfect.

<hr>

<h5>Header Templates</h5>

Here we keep running through our processes and we load our [Header templates](https://github.com/xjackk/TwitchTVExpose/blob/master/js/apps/header/list/templates.coffee) all in one file.

Not much more to be said here.

```
define (require) ->
    item: require("text!apps/header/list/templates/itemview.htm")
    header: require("text!apps/header/list/templates/header.htm")
    login: require("text!apps/header/list/templates/login.htm")
    layout: require("text!apps/header/list/templates/layout.htm")

```

<hr>

<h5>Header Views</h5>

Our header view is just us putting these templates into our ItemViews. We give it a tagName of `li` to attach it to the DOM element.

You can see in our Layout view that the only thing we need to do is specific the region which we already layed out in our HTML. `#list-region`


```
define ['apps/header/list/templates', 'views/_base'], (Templates, AppView) ->

    class _itemview extends AppView.ItemView
        template: _.template(Templates.item)
        tagName: "li"

    LoginView: class Loginview extends AppView.ItemView
        template: _.template(Templates.login)
        el: "#login"

    HeaderView: class ListHeaders extends AppView.CompositeView
        template: _.template(Templates.header)
        itemView: _itemview
        itemViewContainer: "ul"

    Layout: class Header extends AppView.Layout
        template: _.template(Templates.layout)
        regions:
            listRegion: "#list-region"

```

<hr>

The Footer App
==============

The footer [app](https://github.com/xjackk/TwitchTVExpose/blob/master/js/apps/footer/app.coffee) is virtually the same thing as the header app. We are going for that fixed footer look.

Here is our [markup](https://github.com/xjackk/TwitchTVExpose/blob/master/js/apps/footer/show/templates/footer.htm) for the footer. Just some more bootstrapping.

<hr>

<h5>Footer Controller</h5>

In the [controller](https://github.com/xjackk/TwitchTVExpose/blob/master/js/apps/footer/show/controller.coffee) we are just pulling in our `"authorModel:info` and setting our `@footerView`

`getFooterView` passes through our model in an Itemview.


```
    class Controller extends AppController
        initialize:->
            author = msgBus.reqres.request "get:authorModel:info"
            #console.log author
            footerView = @getFooterView author
            @show footerView

        getFooterView: (model) ->
            new View.ItemView
                model: model

```

<hr>

<h5>Footer Templates</h5>

Here we are once again following our AMD approach and loading our [templates](https://github.com/xjackk/TwitchTVExpose/blob/master/js/apps/footer/show/templates.coffee) in like so.

<hr>

<h5>Footer Views</h5>

Our footer view is just a simple Itemview, like so

```
# show footer views.
define ['views/_base', 'apps/footer/show/templates'], (AppViews, Templates) ->

	ItemView: class ShowFooterView extends AppViews.ItemView
		template: _.template(Templates.footer)

		modelEvents:
			"change" : "render"
```

<hr>

The Games App
==============

The games app is probably the the most (or one of the most...) important apps that we will be taking a look at.

This is where we will be showing our `top/games` call from. From there, we can pick everything thing else out we want from Twitch's API. We stuff all the games into a composite view.

Here is the start of our app, where we create <strong>two</strong> controllers. Check it out.

```

define ["msgbus", "marionette", "backbone", "apps/games/list/controller","apps/games/detail/controller"], (msgBus, Marionette, Backbone, ListController, DetailController) ->

    class Router extends Marionette.AppRouter
        appRoutes:
            "games": "list"
            "games/:id/detail": "detail"

    API =
        list: ->
            new ListController

        detail: (id, model) ->
            new DetailController
                gameName: id
                gameModel: model


    msgBus.events.on "app:game:detail", (model) ->
        Backbone.history.navigate "games/#{model.get("game").name}/detail", trigger:false
        console.log "APP:GAMES:LIST=> (from list controller) MODEL", model
        API.detail model.get("game").name, model

    msgBus.commands.setHandler "start:games:app", ->
        new Router
            controller: API

```

Here we create our `list` controller, as well as our `detail` controller. This is because we essentially want to create two views of this.

We have some fancy `backbone.history()` code going on, but this is specifically for routing. We will go into more detail later about routing our app properly.

One view is going to be where the games are all shown, and the other where one selected game is shown, thus, the `detail` controller.

<hr>

<h5>Games Controllers</h5>

Let's get right down to it, starting with the `list` controller.

```
define ["msgbus", "apps/games/list/views", "controller/_base", "backbone" ], (msgBus, Views, AppController, Backbone) ->
    class Controller extends AppController
        initialize: (options={})->
            entities=msgBus.reqres.request "games:top:entities"
            @layout = @getLayoutView()

            @listenTo @layout, "show", =>
                @gameRegion entities
                #@showIntroView()

            @show @layout,
                loading:
                    entities: entities

        gameRegion: (collection)  ->
            view = @getGameView collection
            @listenTo view, "childview:game:item:clicked", (child, args) ->  # listen to events from itemview (we've overridden the eventnamePrefix to childview)
                console.log "game:item:clicked => model", args.model
                msgBus.events.trigger "app:game:detail", args.model

            @listenTo view, "scroll:more", ->
                msgBus.reqres.request "games:fetchmore"

            @layout.gameRegion.show view

        getGameView: (collection) ->
            new Views.TopGameList
                collection: collection

        getLayoutView: ->
            new Views.Layout

#        getIntroView: ->
#            new Views.Intro

#        showIntroView: ->
#            @introView = @getIntroView()
#            @show @introView, region: @layout.streamRegion

```

This controller is all about working directly with our Twitch API. We set entities as our msgBus request to get the `"games:top:entities"`

We define our `gameRegion` and pass through our collection of



