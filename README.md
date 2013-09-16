TwitchTVExpose
==============


<h3>A Single Page Web App implementing TwitchTV's API functionality. Uses Marionette, AMD, RequireJS, Coffeescript, and D3.</h3>

<h4>See It Live! [Live Site on Cloud9!](https://c9.io/xjackk/twitchtvexpose/workspace/index.htm)</h4>

#To Login !

Gain authorization with your Twitch TV account by logging in via the button.

<h3>Using Coffeescript</h3>

Using Coffeescript has saved me writing much code as it compiles into JS. The Coffeescript syntax is a bit Python/Ruby esque, therefore attracting more and more attention recently.
I have switched over to using Coffeescript, and I really really do love it. It saves me syntax headaches, and is just a breeze to write it. I reccomend trying it.

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

<h4>The about app starts with the [app.coffee File.](https://github.com/xjackk/TwitchTVExpose/blob/master/js/apps/about/app.coffee)</h4>

This file acts as the starting point of the app where we add a controller, and set an event handler to "start" off this app, as all these apps will be loaded beforehand, elsewhere.
We will go into more detail later about that.

</h6>About Controller</h6>

[About Controller](https://github.com/xjackk/TwitchTVExpose/blob/master/js/apps/about/show/controller.coffee)

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

<h6>About Templates</h6>

[About Templates](https://github.com/xjackk/TwitchTVExpose/blob/master/js/apps/about/show/templates.coffee)

Here we load our templates for our regions. Nothing too crazy here.


<h6>About Views</h6>

[About Views](https://github.com/xjackk/TwitchTVExpose/blob/master/js/apps/about/show/views.coffee)

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

