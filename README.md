TwitchTVExpose
==============

<blockquote>A Single Page Web App implementing TwitchTV's API functionality. Uses Marionette, AMD, RequireJS, Coffeescript, and D3.</blockquote>

#Login

<blockquote>Gain authorization with your Twitch TV account by logging in.</blockquote>

<br>


***Install BOWER and Coffee-script ***
~~~
$ npm install -g bower
$ npm install -g coffee-script
~~~

Bower will be installed globally

### Project Dependencie ###
* See [bower.json](https://github.com/xjackk/twitchtvexpose/blob/master/bower.json) to see this project's dependencies

### install project dependencies
~~~
$ bower install
~~~

As time passes on, update the project dependencies with **ONE** command:
~~~
$ bower update
~~~

## The M in AMD-- Benefit and a Curse
Modular design in javascript is the key to building scaleable and maintainable web applications.  However, each module can create multiple http get
requests when our page loads.  Remove the __curse__ with [R.js](git://github.com/jrburke/r.js.git) optimizer.


### top[game] application
Drill down on the modular source for the apps/book application listed below.  Notice how the apps/book/app _requires_ the apps/book/list/controller module.
The CONTROLLER _requires_ the VIEWS module and the VIEWS module _requires_ the TEMPLATES module and the __templates__ are ultimately made of __HTML__ snippets in {{MUSTACHE}} format.
* __apps__
    * __top__
        * __list__
            * [controller.coffee](https://github.com/t2k/backbone.marionette-RequireJS/blob/master/assetsAMD/js/apps/book/list/controller.coffee) - the book list controller
            * [templates.coffee](https://github.com/t2k/backbone.marionette-RequireJS/blob/master/assetsAMD/js/apps/book/list/templates.coffee) - the book list templates
            * [views.coffee](https://github.com/t2k/backbone.marionette-RequireJS/blob/master/assetsAMD/js/apps/book/list/views.coffee) - the book list views
            * __templates__ (template files <3 mustache format)
                *  [layout.htm](https://github.com/t2k/backbone.marionette-RequireJS/blob/master/assetsAMD/js/apps/book/list/templates/layout.htm)
                *  [book.htm](https://github.com/t2k/backbone.marionette-RequireJS/blob/master/assetsAMD/js/apps/book/list/templates/book.htm)
                *  [booklist.htm](https://github.com/t2k/backbone.marionette-RequireJS/blob/master/assetsAMD/js/apps/book/list/templates/booklist.htm)
    *  [app.coffee](https://github.com/t2k/backbone.marionette-RequireJS/blob/master/assetsAMD/js/apps/book/app.coffee) - apps/book/app  the book application
* [app.coffee](https://github.com/t2k/backbone.marionette-RequireJS/blob/master/assetsAMD/js/app.coffee)  - app (the main marionette application)
