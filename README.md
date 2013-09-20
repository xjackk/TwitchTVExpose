TwitchTVExpose
==============


<h3>A Single Page Web App implementing TwitchTV's API functionality. Uses Marionette, AMD, RequireJS, Coffeescript, and D3.</h3>

<h4>See It Live! [Live Site on Cloud9!](https://c9.io/xjackk/twitchtvexpose/workspace/index.htm)</h4>

<h3>Using Coffeescript</h3>

Using Coffeescript has saved me writing much code as it compiles into JS. The Coffeescript syntax is a bit Python/Ruby esque, therefore attracting more and more attention recently.
I have switched over to using Coffeescript, and I really really do love it. It saves me syntax headaches, and is just a breeze to write in. I reccomend trying it.

~~~
$ npm install -g coffee-script
~~~

<strong>Keep in mind, you need to make sure you are watching proper directories for compiling your coffeescript. In this command, I output my JS folder</strong>

~~~
$ coffee -o js/ -cw js/
~~~

<h3>Project Dependencies</h3>

<strong>See [bower.json](https://github.com/xjackk/twitchtvexpose/blob/master/bower.json) to see this project's dependencies</strong>

Here, with one command, we can install all of our dependencies.

~~~
$ bower install
~~~

As time passes on, you can update the project with one command as well.

~~~
$ bower update
~~~

This does as it seems, and will keep your bower dependencies up to date.

<br>

<h3>Using AMD</h3>

In this project we are using a very "Rails esque" approach. We keep everything as modular as possible, and stray away from "spaghetti" codeing.

This follows Brian Mann's Marionette approach using RequireJS with Javascript patterns.

<hr>


Before we can start...
==============

Before we can start with our AMD app, we need to make sure we are loading everything properly. In the [Js/apps](https://github.com/xjackk/TwitchTVExpose/tree/master/js/apps) folder, we have a [load.coffee](https://github.com/xjackk/TwitchTVExpose/blob/master/js/apps/load.coffee)
file dynamically loads all of our apps before they are started.

Anytime you add an app, we need to make sure we are adding it to this list. A small mistake I've made in the past that I hope you can avoid. (:

<h5>Config</h5>

In our [config load](https://github.com/xjackk/TwitchTVExpose/blob/master/js/config/load.coffee) file, we load dependencies also from other areas in our app. Make sure you load these, as they are important.


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

After this, we pass those item views into our composite views with an "itemviewcontainer" like so.


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

Here is our [markup](https://github.com/xjackk/TwitchTVExpose/blob/master/js/apps/footer/show/templates/footer.htm)for the footer. Just some more bootstrapping.

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

