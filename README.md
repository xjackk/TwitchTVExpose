###TwitchTVExpose

TwitchTVExpose is a Single Page Client App implementing TwitchTV's API functionality. Using Backbone.Marionette, RequireJS, Coffeescript, and a little D3 view to mix things up.

Check out the live site: [TwitchTVExpose](http://twitchtvexpose.herokuapp.com/)


![Screenshot][ss]

[ss]: https://github.com/xjackk/twitchtvexpose/raw/master/doc/image/TwitchTVExpose.png "Screen shot: TwitchTV Expose"

---

###Why Did You Do It, Jack?

Over the summer I did a lot of research on what I really wanted my first open source project to be about. Since I am a gamer and frequent user of the [Twitch.tv](http://www.twitch.tv) site I began to realize ways their site could be reworked for a better user experience.

From there, I decided it would be a perfect first project to take what twitchtv had, and do it better.  I'd views alot of Brian Manns' [BackboneRails](http://backbonerails.com) tutorials and decided to use Backbone Marionette to build a responsive front-end app. I got to work all summer and this was the outcome.

When I land at twitch.tv, I just want to find favorite games with their live streams and watch it quickly. This app takes twitchtv, and makes the selection and viewing process faster and a better experience for the user. No hassles with page-postbacks and such. All client-side JS, in a single-page app.

For a list of resources I used to create this app, visit the About page on my app to see what I used to make this happen...

Cheers !


###Coffeescript

Using Coffeescript has saved me writing much code as it compiles right into JS. The Coffeescript syntax is a bit Python/Ruby-esque, therefore attracting more and more attention recently.
I have switched over to using Coffeescript fulltime, and I really do love it. It saves me syntax headaches, and is just a breeze to write in. I reccomend trying it.

~~~
$ npm install -g coffee-script
~~~

Keep in mind the watching directory and the output directory for compiling coffeescript to javascript. In this command, the `js` folder contains both my coffee files and js output.

~~~
$ coffee -o js/ -cw js/
~~~

---

###Project Dependencies

Check out [bower.json](https://github.com/xjackk/twitchtvexpose/blob/master/bower.json) to see the project's complete open-source dependencies.


With [BOWER](https://github.com/bower/bower), just one command and all of the project dependencies are installed:

~~~
$ bower install
~~~

As time marches on, update project dependencies with one command:

~~~
$ bower update
~~~

###Asyncronous Module Definition (AMD) and [RequireJS](http://requirejs.org)

This project uses a "Rails-esque" approach-- *convention over configuration.*  Apps are organized and kept in a conventional way :

![About App][about_app]

All templates use [underscore](http://underscorejs.org) [configured for Mustache](https://github.com/xjackk/TwitchTVExpose/blob/master/js/config/underscore/templatesettings.coffee).
I follow an approach *similar* to Brian Mann's [BackboneRails](http://backbonerails.com) tutorials except he is using Rails and
Marionette.modules and I am using RequireJS/AMD modules with a Rails convention.  Sort of a Rails/AMD hybrid that works very well for me.

Take a look at the About app above and notice how the files are organized:
+ apps/about/app.coffee  (the application)
+ apps/about/show/controller.coffee (the show controller)
+ apps/about/show/templates/*.htm  (various templates)
+ apps/about/show/views.coffee  (modular views)
+ apps/about/show/templates.coffee (modular templates)

*This convention is followed for all apps in this project...*

[about_app]: https://github.com/xjackk/twitchtvexpose/raw/master/doc/image/aboutapp.png "modular app convention"

---

###Boot-up: *AMD Asset Pipeline*

Before the [js/app.coffee](https://github.com/xjackk/TwitchTVExpose/tree/master/js/app.coffee) can be started, number of modules must be loaded first. **RequireJS** helps in this regard however the explicit dependencies must be established and the loading process managed.  Unfortunately this is something that is not automagically done and must be handled with a little common sense. Before this modular app can load a number of Configuraion, Enity and App modules will need to be pre-loaded before the Marionette.application can start.

> **Asset Pipeline**

>   [js/main.coffee](https://github.com/xjackk/TwitchTVExpose/blob/master/js/main.coffee)  >> defines app dependencies

>   [config/load.coffee](https://github.com/xjackk/TwitchTVExpose/blob/master/js/config/load.coffee) >> load app configuration  and entities

>   [js/apps/load.coffee](https://github.com/xjackk/TwitchTVExpose/blob/master/js/apps/load.coffee) >> loads apps and sub-apps prior to the main app


This is roughly equivalent to the Rails asset pipeline demonstated in Brian Mann's tutorials.

---

###Entities

The [**js/entities**](https://github.com/xjackk/TwitchTVExpose/tree/master/js/entities) folder contains the project data models. It's important to see how the entities use the [js/msgbus.coffee](https://github.com/xjackk/TwitchTVExpose/blob/master/js/msgbus.coffee) pattern for intra-app communication.

The primary entity used throughout is [js/entities/twitchtv.coffee](https://github.com/xjackk/TwitchTVExpose/blob/master/js/entities/twitchtv.coffee)  It uses backbone collections and implements endless scrolling for the games and streams API

---

####How this all works. (Featuring msgBus)

The msgbus module exposes the reqest/response, command and events objects from  *backbone.wreqr* works.

~~~
# msgbus decoupled from app
define ["backbone.wreqr"], (Wreqr) ->
    reqres: new Wreqr.RequestResponse()
    commands: new Wreqr.Commands()
    events: new Wreqr.EventAggregator()
~~~

The msgBus allows app modules to set handlers for: events, request/response and commands. These three patterns: **pub/sub**, **reqest/response** and **command** are bundled together in the ***msgbus*** module.
Msgbus is used throughout the application providing an effective architecture for building de-coupled AMD style modules.  This enables the application to scale easily and efficiently. *The way to build large javascript applications is not to build large javascript applications...*

A quick example of this is can be seen in the `header:entities`

This decoupled code right here provides us with a way to dynamically pull in these entities the header app, without repeating ourselves. This keeps a very "modular" approach to building this app.

[`js/entities/header.coffee`](https://github.com/xjackk/TwitchTVExpose/blob/master/js/entities/header.coffee)

~~~
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
~~~

Notice how the header entity module uses the msgBus module to listen for a `header:entities` request and responds with a static `Backbone.Collection`


---

###Starting the App
Before describing code, lets take a look at the index.htm markup, it's very brief:
~~~
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>Twitch-TV Expose</title>
    <meta name="description" content="Single Page Application Backbone Marionette RequireJS">
    <meta name="author" content="Jack Killilea">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- Le HTML5 shim, for IE6-8 support of HTML5 elements -->
    <!--[if lt IE 9]>
        <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->
    <link href="bower_components/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet" media=screen>
    <link href="css/main.css" rel="stylesheet" media=screen>
    <style type="text/css">
</style>
</head>
<body>
    <div id="wrap">
        <div id="header-region"></div>
        <div id="main-region" class="container"></div>
    </div>
    <div id="footer-region"></div>
    <script data-main="js/main.optimized" src="bower_components/requirejs/require.js" type="text/javascript"></script>
</body>
</html>
~~~

The body contains a `<div id="header-region"></div>`,  `<div id="main-region" class="container"></div>` and a `<div id="footer-region"></div>`.  The #wrap is the [bootstrap](http://getbootstrap.com/examples/sticky-footer/) suggested way of creating a sticky footer.
So this being a client side app, the UI interactions will be taking place inside the #main-region:



####[Main.coffee](https://github.com/xjackk/TwitchTVExpose/blob/master/js/main.coffee)

Here is the main file where we preload all of our dependencies. It very "modular" approach to building this app, so this is where we load everything, then start the app.

Before diving into each seperate app, I'll introduce the initial "app" for this project. This is where the Marionette.Application is created control of the sub-app startup process is controlled.

[js/app.coffee](https://github.com/xjackk/TwitchTVExpose/blob/master/js/app.coffee)

In this big guy here, we add some "planning" for the rest of our project. We add our primary regions of the single page app, as well as the default routing.

Here are all of our handlers for our regions.

```
    msgBus.reqres.setHandler "default:region",->
        app.mainRegion

    msgBus.reqres.setHandler "header:region", ->
        app.headerRegion

    msgBus.reqres.setHandler "footer:region", ->
        app.footerRegion

    msgBus.reqres.setHandler "main:region", ->
        app.mainRegion

    #debugging support
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

---
###The About App
The about app starts with the respective app file.

[`js/apps/about/app.coffee`](https://github.com/xjackk/TwitchTVExpose/blob/master/js/apps/about/app.coffee)

This file acts as the starting point of the app where we add a controller, and set an event handler to "start" off this app, as all these apps will be loaded beforehand, elsewhere.
We will go into more detail later about that.

---

###About Show Controller

[`js/apps/about/show/controller.coffee`](https://github.com/xjackk/TwitchTVExpose/blob/master/js/apps/about/show/controller.coffee)

The about Controller sets up sets up the three regions we will be adding data too.

+ About Region
+ Books Region
+ OSS Region


```
aboutRegion: ->
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

getAboutView: ->
    new Views.About

getLayoutView: ->
    new Views.Layout
```

###About Templates
[`js/apps/about/show/templates.coffee`](https://github.com/xjackk/TwitchTVExpose/blob/master/js/apps/about/show/templates.coffee)

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

---

###About Views

[`js/apps/about/show/views.coffee`](https://github.com/xjackk/TwitchTVExpose/blob/master/js/apps/about/show/views.coffee)

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

---
###The Header App
The header app starts with it's corrosponding app file, which creates out list controller, and starts the app.

[App file](https://github.com/xjackk/TwitchTVExpose/blob/master/js/apps/header/app.coffee)

Once we have this, we can move on to our app itself. We begin to layout everything using [Bootstrap](getbootstrap.com) in our header.

[Header.htm](https://github.com/xjackk/TwitchTVExpose/blob/master/js/apps/header/list/templates/header.htm)

We only have one region for this header, and we lay it out, like so.

[Layout.htm](https://github.com/xjackk/TwitchTVExpose/blob/master/js/apps/header/list/templates/layout.htm)

Lastly, we need a login button, to authorize ourselves with Twitch TV's API.

[Twitch.TV Login](https://github.com/xjackk/TwitchTVExpose/blob/master/js/apps/header/list/templates/login.htm)

After we layout all of our html, we can move onto working with our controllers, templates, and views.

---

###Header Controller


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
        @loginView.render() #stick-it into the DOM

        @show @layout

```

We need to set up our msgbug requrests for getting our header and update our "appstate". Our new appstate is a property of our controller and we can listen
to specific events going on. In our case, we want to see if we are logged in, or not.

Our last line,`loginview.render()` will stick our loginview right into our DOM. Perfect.

---

####Header Templates

Here we keep running through our processes and we load our [Header templates](https://github.com/xjackk/TwitchTVExpose/blob/master/js/apps/header/list/templates.coffee) all in one file.

Not much more to be said here. Here are our header htm templates.

[Header](https://github.com/xjackk/TwitchTVExpose/blob/master/js/apps/header/list/templates/header.htm)
[Itemview](https://github.com/xjackk/TwitchTVExpose/blob/master/js/apps/header/list/templates/itemview.htm)
[Layout](https://github.com/xjackk/TwitchTVExpose/blob/master/js/apps/header/list/templates/layout.htm)
[Login](https://github.com/xjackk/TwitchTVExpose/blob/master/js/apps/header/list/templates/login.htm)

---

####Header Views

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

---
###The Footer App

The footer [app](https://github.com/xjackk/TwitchTVExpose/blob/master/js/apps/footer/app.coffee) is virtually the same thing as the header app. We are going for that fixed footer look.

Here is our [markup](https://github.com/xjackk/TwitchTVExpose/blob/master/js/apps/footer/show/templates/footer.htm) for the footer. Just some more bootstrapping.

---

###Footer Controller

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

###Footer Templates

Here we are once again following our AMD approach and loading our [templates](https://github.com/xjackk/TwitchTVExpose/blob/master/js/apps/footer/show/templates.coffee) in like so.

Our footer htm template as well.

[`Footer`](https://github.com/xjackk/TwitchTVExpose/blob/master/js/apps/footer/show/templates/footer.htm)

---

###Footer Views

Our footer view is just a simple Itemview, like so

```
# show footer views.
define ['views/_base', 'apps/footer/show/templates'], (AppViews, Templates) ->

    ItemView: class ShowFooterView extends AppViews.ItemView
        template: _.template(Templates.footer)

        modelEvents:
            "change" : "render"
```

---

##The Games App

The games app is the the most important app in this project.  The games app is responsible for routing msgbus two controllers:
+   games list
+   game detail

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
        API.detail model.get("game").name, model

    msgBus.commands.setHandler "start:games:app", ->
        new Router
            controller: API
```

Here we create our `list` controller, as well as our `detail` controller. This is because we essentially want to create two views of this.

We have some fancy `backbone.history()` code going on, but this is specifically for routing. We will go into more detail later about routing our app properly.

One view is going to be where the games are all shown, and the other where one selected game is shown, thus, the `detail` controller.

---

###Games Controllers

Let's get right down to it, starting with the `list` controller.

```
define ["msgbus", "apps/games/list/views", "controller/_base", "backbone" ], (msgBus, Views, AppController, Backbone) ->
    class Controller extends AppController
        initialize: (options={})->
            @entities=msgBus.reqres.request "games:top:entities"
            @layout = @getLayoutView()

            @listenTo @layout, "show", =>
                @gameRegion() # @entities

            @listenTo @layout, "show:bubble", =>
                @gameBubbleRegion() # @entities

            @show @layout,
                loading:
                    entities: @entities

        gameRegion:   ->
            view = @getGameView @entities
            @listenTo view, "childview:game:item:clicked", (child, args) ->  # listen to events from itemview (we've overridden the eventnamePrefix to childview)
                #console.log "game:item:clicked => model", args.model
                msgBus.events.trigger "app:game:detail", args.model

            @listenTo view, "scroll:more", ->
                msgBus.reqres.request "games:fetchmore"

            @layout.gameRegion.show view

        gameBubbleRegion:   ->
            view = @getBubbleView @entities
            @layout.gameRegion.show view

        getBubbleView: (collection) ->
            new Views.GamesBubbleView
                collection: collection


        getGameView: (collection) ->
            new Views.TopGameList
                collection: collection

        getLayoutView: ->
            new Views.Layout
```

This controller is all about working directly with our Twitch API. We set entities as our msgBus request to get the `"games:top:entities"`

We define our `gameRegion` and pass through our collection. You can see we're listening to a `childview:game:item:clicked`. This is listening to events from our itemview.

This will trigger our `app:game:detail` event. We also have our next `@listenTo` which listens to the view for a `scroll:more`. This launches our `games:fetchmore` which works as a "endless scrolling" feature.

Lastly in this controller, we have our `getGameView` function which passes a collection into a new view.


###Detail Controller

After our `list` controller, we have our `detail` controller. This controller will be dealing with our games detail view. Let's check it out.

```
define ["msgbus", "apps/games/detail/views", "controller/_base", "backbone" ], (msgBus, Views, AppController, Backbone) ->
    class Controller extends AppController
        initialize: (options) ->
            {gameName, gameModel} = options
            #console.log "OPTIONS passed to detail controller", options

            if gameModel is undefined
                gameModel = msgBus.reqres.request "games:searchName", gameName
                #console.log "GameModel", gameModel

            @layout = @getLayoutView()
            @listenTo @layout, "show", =>
                @gameRegion gameModel

            @show @layout,
                loading:
                    entities: gameModel


        gameRegion: (model) ->
            view = @getGameView model
            msgBus.commands.execute "app:stream:list", @layout.streamRegion, model.get("game").name
            @layout.gameRegion.show view


        getGameView: (model) ->
            new Views.Detail
                model: model

        getLayoutView: ->
            new Views.Layout
```

You can see right from the define statement, this controller is going to be working directly with our `games/detail/view`.

In our `initialize` function we are pasing through `gameName`, and `gameModel` as options.

We then have our `if` statement, which says if our `gameModel` is undefined, then its going to make a `msgBus.reqres.request` for `games:searchName` which passes through a `gameName`.

Next, we are getting our layoutview, and listening to our show event. Nothing new here. Our `@gameRegion` is passing through our `gameModel`

Finally we have our functions for this controller.

`gameRegion` passes through the model and sets its view for that function the `getGameView`. To get our game name here, we make a `msgBus.commands.execute` for the `app:stream:list`.

`getGameView` passes through a model as well and makes a new detail view.

---

###List Templates

Continuing on with our `list` section of our games app, we have our [templates](https://github.com/xjackk/TwitchTVExpose/blob/master/js/apps/games/list/templates.coffee).

Our htm templates as well for our `list`.

[Gameitem](https://github.com/xjackk/TwitchTVExpose/blob/master/js/apps/games/list/templates/gameitem.htm)
[Gamelist](https://github.com/xjackk/TwitchTVExpose/blob/master/js/apps/games/list/templates/gamelist.htm)
[Intro](https://github.com/xjackk/TwitchTVExpose/blob/master/js/apps/games/list/templates/intro.htm)
[Layout](https://github.com/xjackk/TwitchTVExpose/blob/master/js/apps/games/list/templates/layout.htm)

---

###List Views

More to say about our `list` View, we have quite a bit going on here.

```

define ['apps/games/list/templates', 'views/_base', 'msgbus'], (Templates, AppView, msgBus) ->

    class GameItem extends AppView.ItemView
        template: _.template(Templates.gameitem)
        tagName: "li"
        className: "col-md-2 col-sm-4 col-xs-12 game"
        triggers:
            "click" : "game:item:clicked"

    TopGameList: class TopGameList extends AppView.CompositeView
        template: _.template(Templates.gamelist)
        itemView: GameItem
        id: "gamelist"
        itemViewContainer: "#gameitems"

        events:
            "scroll": "checkScroll"

        checkScroll: (e) =>
            virtualHeight = @$("> div").height() #important this div must have css height: 100% to enable calculattion of virtual height scroll
            scrollTop = @$el.scrollTop() + @$el.height()
            margin = 200
            #console.log "virtualHeight:", virtualHeight, "scrollTop:", scrollTop, "elHeight", @$el.height()
            if ((scrollTop + margin) >= virtualHeight)
            @trigger "scroll:more"

    Intro: class Intro extends AppView.ItemView
        template: _.template(Templates.intro)

    Layout: class GamesLayout extends AppView.Layout
        template: _.template(Templates.layout)
        regions:
            gameRegion: "#game-region"
            #streamRegion: "#stream-region"

```

Our first class `GameItem` is simply an ItemView with a familiar looking `className`. You should recognize this as bootstrapping. We need to give this GameItem a click event as well for more or less obvious reasons.

Next we have our `TopGameList` class which is a CompositeView. This takes our `GameItem` class as its itemView, and gives it an `id` of `gamelist`. We need a container to put this it too, right? Of course.
we give it an `itemViewContainer` of `#gameitems`.

Before we end this class, we need an event for our endless scroll so we set `scroll:` as `checkScroll`.

Here we hve our `checkScroll` function which passes through one arg. Before we go into the code line by line, we need to understand how this works.

`VirtualHeight` here is very important, as it works as the height of the actual page. It's almost imaginary in a way because we aren't going to be seeing the whole height, as it is in a module smaller than the size of the whole page.
this `div` must have the css height of `100%` to enable proper calculation of the `VirtualHeight`.

We then set `scrollTop` which is this `el`'s height plus the `scrolltop`. We set our `margin` to 200px.

Lastly, we have our `if` statement which is saying if the `scrollTop` + `margin` is greater than our `virtualHeight`, it will trigger an event to `scroll:more`.
You can kinda see wher ewe are going with this.

On a less important note, we have a `Layout` class that does this thing where it passes a template though to some regions. Neat.

---

###Detail Templates

Not much to write about the templates. I keep it pretty dry. Check em [out](https://github.com/xjackk/TwitchTVExpose/blob/master/js/apps/games/detail/templates.coffee).

Our htm templates too are nice to look at.

[Gamedetail](https://github.com/xjackk/TwitchTVExpose/blob/master/js/apps/games/detail/templates/gamedetail.htm)
[Layout](https://github.com/xjackk/TwitchTVExpose/blob/master/js/apps/games/detail/templates/layout.htm)

---

###Detail Views

Here we have just an `ItemView` and a `Layout`.

```

define ['apps/games/detail/templates', 'views/_base', 'msgbus'], (Templates, AppView, msgBus) ->

    Detail: class GameDetail extends AppView.ItemView
        template: _.template(Templates.gamedetail)
        className: "col-xs-12"
        #triggers:
            # "click" : "game:item:clicked"


    Layout: class GamesLayout extends AppView.Layout
        template: _.template(Templates.layout)
        regions:
            gameRegion: "#game-region"
            streamRegion: "#stream-region"

```

This class `GameDetail` is our Itemview. We are passing in our `gamedetail` template, and giving it a bootstrap `className`.

Our class `GamesLayout` just gives us our `gameRegion` and `streamRegion`.

---


##The Streams App

After all has been said and done with our Games App, we can move on to our Streams section.

```

define [ "msgbus", "apps/streams/list/controller" ], (msgBus, Controller) ->

    API =
        list:(region, name) ->
        new Controller
        region: region
        name: name

    msgBus.commands.setHandler "app:stream:list", (region, name) ->
        API.list region, name
```

Here is our Streams App, where we start our `list` API, and pass in a region and name to the controller.

Lastly we have our trusty `msgBus` comand, to the `app:stream:list`.

---

###Streams Controller

Our streams [controller](https://github.com/xjackk/TwitchTVExpose/blob/master/js/apps/streams/list/controller.coffee)

Lets check it out.

```

define ["msgbus", "apps/streams/list/views", "controller/_base" ], (msgBus, Views, AppController) ->
    class Controller extends AppController
        initialize:(options={})->
            {name} = options
            console.log "streams:list:controller OPTIONS", options
            streamEntities = msgBus.reqres.request "search:stream:entities", name
            view = @getListView streamEntities

            @listenTo view, "childview:stream:item:clicked", (child, args) -> # listen to events from itemview (we've overridden the eventnamePrefix to childview)
            #console.log "game:item:clicked" , args.model
            msgBus.events.trigger "app:playa:show", args.model

            @listenTo view, "scroll:more", ->
            #console.log "listen to scroll:more"
            msgBus.reqres.request "streams:fetchmore"


            @show view,
                loading: true

        getListView: (collection) ->
            new Views.ListView
            collection: collection

```

In our `initalize` function we are passing in our options. We slyly pass in name as a hash to options.

Our `streamEntities` is just a `msgBus.reqres.request` to our `search:stream:entities`, where we pass through name as an arg.

To finish off our `initalize` we are setting the view as `@getListView` and passing in our `streamEntities`.

In our next block of code, we are listening to the click event the same way we have before. We need to listen to the events from our `itemview`.
As you can see, we have `msgBus.events.trigger` to trigger `app:playa:show` on this `@listenTo`.

Lastly we are creating our `getListView` function where we pass through our collection as a new view. Nothing we haven't seen before.

---

###Stream Templates

Same as always, here we are loading our stream [templates](https://github.com/xjackk/TwitchTVExpose/blob/master/js/apps/streams/list/templates.coffee). So nice.

Also here are our htm templates for this.

[Streamitem](https://github.com/xjackk/TwitchTVExpose/blob/master/js/apps/streams/list/templates/streamitem.htm)

[Streams](https://github.com/xjackk/TwitchTVExpose/blob/master/js/apps/streams/list/templates/streams.htm)

---

###Stream Views

Following our Templates, we have our views. Heeeeeere we go.

```
define ['views/_base', 'apps/streams/list/templates'], (AppViews, Templates) ->

    class StreamItem extends AppViews.ItemView
        template: _.template(Templates.streamitem)
        tagName: "li"
        className: "col-md-6 col-xs-12"
        triggers:
            "click" : "stream:item:clicked"

    ListView: class StreamList extends AppViews.CompositeView
        template: _.template(Templates.streams)
        itemView: StreamItem
        itemViewContainer: "#items"
        id: "streamlist"

        events:
            "scroll": "checkScroll"

        checkScroll: (e) =>
            virtualHeight = @$("> div").height() #important this div must have css height: 100% to enable calculattion of virtual height scroll
            scrollTop = @$el.scrollTop() + @$el.height()
            margin = 200
            console.log "virtualHeight:", virtualHeight, "scrollTop:", scrollTop, "elHeight", @$el.height()
            if ((scrollTop + margin) >= virtualHeight)
            console.log "scroll:more"
            @trigger "scroll:more"

```

Our `StreamItem` class is our ItemView. We give it a `li` tagname and the same `className` that we have been seeing for a while. I hope this looks rather familiar.

Of course our itemview is going to need a `click` event, so we add the appropriate `triggers`.

Our next class is our `StreamList` which is none other than our CompositeView.

`StreamList` simply pulls our `itemView` into our Compositeview, and sets our `itemViewContainer` as `#items`. Looks familiar also, eh?

Lastly we have our classic endless scroll function.

I went over how it worked before in the `Games` app, so I'm not sure if i should repeat myself. You get it now.

---

##The Player App


The last thing we're going to go into is our actual Player [application.](https://github.com/xjackk/TwitchTVExpose/blob/master/js/apps/playa/app.coffee)

In our app, we're setting a new controller and passing a model through to it. Nothing new here.

The `msgBus.events.on` you see is purely for routing. We can talk about this later.

---

###Player Controller

In our player [controller](https://github.com/xjackk/TwitchTVExpose/blob/master/js/apps/playa/show/controller.coffee) we are bascially passing our model to everything.

```

define ["apps/playa/show/views", "controller/_base"], (Views, AppController) ->

    class Controller extends AppController
        initialize:(options={})->
            {model} = options
            @layout = @getLayoutView()
            @listenTo @layout, "show", =>
            @playerRegion model
            @userRegion model
            @chatRegion model

            @show @layout

        playerRegion: (model) ->
            player = @getPlayerView model
            @layout.playerRegion.show player

        chatRegion: (model) ->
            chat = @getChatView model
            @layout.chatRegion.show chat

        userRegion: (model) ->
            userView = @getUserView model
            @layout.userRegion.show userView

        getPlayerView: (model) ->
            new Views.Player
            model: model

        getChatView: (model) ->
            new Views.Chat
            model: model

        getUserView: (model) ->
            new Views.User
            model: model

        getLayoutView: ->
            new Views.Layout

```

In oour `initialize` function we are passing through options, yet cleverly hasing in `{model}` to options.
Next is almost a standard procedure. We need to listen for our show event, where we have a `@playerRegion`, `@userRegion`, and a `@chatRegion`, which all passes `model` through.

In our `playerRegion` function, we are simply getting our player view, and showing it.
This is the same for the `chatRegion` and `userRegion` respectively.

our `get` functions are the same idea, just passing through model, and making a new view. Cool. Let's move on.

---

###Player Templates

More [templates](https://github.com/xjackk/TwitchTVExpose/blob/master/js/apps/playa/show/templates.coffee). What'd you expect?

Our htm snippits as well, fool.

[Chat](https://github.com/xjackk/TwitchTVExpose/blob/master/js/apps/playa/show/templates/chat.htm)

[Layout](https://github.com/xjackk/TwitchTVExpose/blob/master/js/apps/playa/show/templates/layout.htm)

[Player](https://github.com/xjackk/TwitchTVExpose/blob/master/js/apps/playa/show/templates/player.htm)

[User](https://github.com/xjackk/TwitchTVExpose/blob/master/js/apps/playa/show/templates/user.htm)

---

###Player View

In the player [view](https://github.com/xjackk/TwitchTVExpose/blob/master/js/apps/playa/show/views.coffee), we are only dealing with `ItemViews`. No `CompositeViews` of any sort; nothing tricky here.

```
define ['apps/playa/show/templates', 'views/_base'], (Templates, AppView) ->

    Player: class Player extends AppView.ItemView
        template: _.template(Templates.player)

    User: class User extends AppView.ItemView
        template: _.template(Templates.user)

    Chat: class Chat extends AppView.ItemView
        template: _.template(Templates.chat)

    Layout: class Layout extends AppView.Layout
        template: _.template(Templates.layout)
        regions:
            playerRegion: "#player-region"
            userRegion: "#user-region"
            chatRegion: "#chat-region"

```

The `Player` class is just an `ItemView` just like the rest of these three classes you see. Nothing crazy at all here... actually the most simple view we've seen so far.

`User` and `Chat` are doing the same... simply passing the template into the `ItemView`. Kids stuff.

Lastly we have our `Layout`, where we are doing a <strong>bit</strong> more work than before, yet still, nothing to sweat over.

We need three regions for these classes, as they are all seperate `ItemViews`, therefore we have `playerRegion`,`userRegion` and `chatRegion`.

---

###More About Our Twitch API


This app was built solely around a popular streaming site's API. Almost all the calls we are making are to Twitch, and not properly documenting how exactly we go about this would be a shame.

We can take a direct look at the huge block of code that we know as our [Twitch Entities](https://github.com/xjackk/TwitchTVExpose/blob/master/js/entities/twitchtv.coffee).

```
define ["entities/_backbone", "msgbus"], (_Backbone, msgBus ) ->
    # this _fetch is our private property added to overridden config backbone sync

    class Game extends _Backbone.Model
    class Stream extends _Backbone.Model

    # differennt class to handle parse of .stream object from the twitch API: looking for a single model
    class StreamGet extends _Backbone.Model
        parse: (response) ->
            response.stream

    class SearchStreams extends _Backbone.Collection
        model: Stream
        parse: (response) ->
            response.streams

    class SearchCollection extends _Backbone.Collection
        model: Game
        parse: (response) ->
            response.games

    class GamesCollection extends _Backbone.Collection
        model: Game

        initialize: ->
            msgBus.reqres.setHandler "games:fetchmore", =>
                @moreGames()

            @limit = 50
            @offset = 0
            @loading = false
            @previousSearch = null
            @_total = null

        moreGames: ->
            return true  if @loading or @length >= @_total
            @loading=true
            @offset++
            #console.log "fetching page #{@offset+1} of games"
            loaded = @fetch
                remove: false
                data:
                    oauth_token: msgBus.reqres.request "get:current:token"
                    limit: @limit
                    offset: @offset * @limit
            $.when(loaded).then =>
                @loading=false
                #console.log "Loaded page", @offset+1, "Games fetched so far", @length, "Total games available to fetch ", @_total

        searchName: (_name)->
            @find (model)->
                model.get("game").name is _name


        parse: (response) ->
            {@_total}=response
            response.top


    class StreamCollection extends _Backbone.Collection
        model: Stream

        initialize: ->
            msgBus.reqres.setHandler "streams:fetchmore", =>
                @moreStreams()

            @limit = 12
            @offset = 0
            @loading = false
            @previousSearch = null
            @_total = null

        moreStreams: ->
            return true  if @loading or @length >= @_total
            @loading=true
            @offset++
            loaded = @fetch
                remove: false
                data:
                    oauth_token: msgBus.reqres.request "get:current:token"
                    q: @game
                    limit: @limit
                    offset: @offset * @limit
            $.when(loaded).then =>
                @loading=false


        parse: (resp) ->
            {@_total}=resp
            resp.streams

    # caching timers initialize
    games = new GamesCollection
    games.timeStamp = new Date()


    #PUBLIC API
    API =
        getGames: (url, params = {}) ->
            #45 seconds elapsed time between TOP game fetches
            elapsedSeconds = Math.round(((new Date() - games.timeStamp ) / 1000) % 60)
            if elapsedSeconds > 45 or games.length is 0
                _.defaults params,
                    oauth_token: msgBus.reqres.request "get:current:token"
                games = new GamesCollection
                games.timeStamp = new Date()
                games.url = "https://api.twitch.tv/kraken/#{url}?callback=?"
                games.fetch
                    reset: true
                    data: params
            games

        searchGames: (url, params = {}) ->
            _.defaults params,
                oauth_token: msgBus.reqres.request "get:current:token"
            sgames = new SearchCollection
            sgames.url = "https://api.twitch.tv/kraken/#{url}?callback=?"
            sgames.fetch
                reset: true
                data: params
            sgames


        getStreams: (url, params = {}) ->
            _.defaults params,
                oauth_token: msgBus.reqres.request "get:current:token"
            streams = new StreamCollection
            streams.game=params.q #tack this on/custom class property
            streams.url = "https://api.twitch.tv/kraken/#{url}?callback=?"
            streams.fetch
                reset: true
                data: params
            streams

        # get stream by channel
        getStream: (url, params = {}) ->
            console.log "getStream", url, params
            _.defaults params,
                oauth_token: msgBus.reqres.request "get:current:token"
            stream = new StreamGet # model
            stream.url = "https://api.twitch.tv/kraken/#{url}?callback=?"
            stream.fetch
                data: params
            stream

    # initial collection search 'top games' twitchAPI
    msgBus.reqres.setHandler "games:top:entities", ->
        API.getGames "games/top",
            limit: 24
            offset: 0

    #implement TWITCHAPI call
    msgBus.reqres.setHandler "search:games", (query)->
        API.searchGames "search/games",
            q: query #encodeURIComponent query
            type: "suggest"
            live: false

    # search internal cached collection for a game models, speed up the UI
    msgBus.reqres.setHandler "games:searchName", (query)->
        games.searchName query

    #search for streams by game
    msgBus.reqres.setHandler "search:stream:entities", (game)->
        API.getStreams "search/streams",
            q: game
            limit: 12
            offset: 0

    # twitchAPI, grab a channels live stream
    msgBus.reqres.setHandler "search:stream:model", (channel)->
        API.getStream "streams/#{channel}"

```

ex nihilo omnia...

