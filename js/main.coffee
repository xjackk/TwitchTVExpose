# require bootloader
require.config

    paths:
        # note these are all AMD compliant versions
        jquery: "../bower_components/jquery/dist/jquery"
        underscore: "../bower_components/underscore/underscore"
        backbone: "../bower_components/backbone/backbone"
        marionette: "../bower_components/backbone.marionette/lib/backbone.marionette"
        "backbone.radio": "../bower_components/backbone.radio/build/backbone.radio"
        moment: "../bower_components/moment/moment"
        nprogress: "../bower_components/nprogress/nprogress"
        globalize: "../bower_components/globalize/lib/globalize"
        text: "../bower_components/requirejs-text/text"
        d3: "../bower_components/d3/d3",
        spin: "../bower_components/spin.js/spin"
        jqueryspin: "../bower_components/spin.js/jquery.spin"
        slimscroll: "../bower_components/jquery-slimscroll/jquery.slimscroll"
        bootstrap:"../bower_components/bootstrap/dist/js/bootstrap"

    shim:
        #mockjax: ["jquery"]
        slimscroll: ["jquery"]
        bootstrap: ["jquery"]

    require ["config/load", "apps/load", "app" ], (_config, _apps, app) ->
    # ensure that base application settings are loaded before we can call the app.  Templates, settings and jquery plugins
        app.start()