TwitchTVExpose
==============

<blockquote>A Single Page Web App implementing TwitchTV's API functionality. Uses Marionette, AMD, RequireJS, Coffeescript, and D3.</blockquote>

##To Build:
+ npm install -g coffee-script
+ npm install -g bower <blockquote>Make sure you have bower <i>installed</i></blockquote>




<strong>Coffee -o js/ -cw js/</strong>

<blockquote>This will compile our coffeescript.</blockquote>

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

### [R.js](https://github.com/jrburke/r.js.git) build Optimizer
Using [R.js](https://github.com/jrburke/r.js.git) optimizer to compress/minimize/uglify your main.js file.  Eliminate or dramatically reduce
server requests upon you first page load.

#### optimize javascript loading with R.js
Here's how I did it for this project in __Cloud9IDE__

__Build the optimized verions of main.js__

Pass the [app.build.js](https://github.com/t2k/backbone.marionette-RequireJS/blob/master/assetsAMD/build/app.build.js) file as a command line
argument to [R.js](https://github.com/jrburke/r.js.git)
~~~
$ cd assetsAMD/build
$ node ../../components/r.js/dist/r.js -o app.build.js
~~~
***This previous step can/should be scrpted into a build process***

SEE [app.build.js](https://github.com/t2k/backbone.marionette-RequireJS/blob/master/assetsAMD/build/app.build.js) for details.

The optimizer 'output' builds the assetsAMD/js/main.optimized.js that gets linked to [indexAMD.html](https://github.com/t2k/backbone.marionette-RequireJS/blob/master/indexAMD.html).

SEE [indexAMD.Devel.html](https://github.com/t2k/backbone.marionette-RequireJS/blob/master/indexAMD.Devel.html) for details.


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
