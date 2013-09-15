TwitchTVExpose
==============


<h3>A Single Page Web App implementing TwitchTV's API functionality. Uses Marionette, AMD, RequireJS, Coffeescript, and D3.</h3>

<h4>See It Live! [Live Site on Cloud9!](https://c9.io/xjackk/twitchtvexpose/workspace/index.htm)</h4>

#To Login !

Gain authorization with your Twitch TV account by logging in via the button.

<h3>Using Coffeescript</h3>

$ npm install -g coffee-script
~~~

<h3>Project Dependencies</h3>

>See [bower.json](https://github.com/xjackk/twitchtvexpose/blob/master/bower.json) to see this project's dependencies

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

The About App
==============

<h4>The about app starts with the [app.coffee File](https://github.com/xjackk/TwitchTVExpose/blob/master/js/apps/about/app.coffee)</h4>

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
