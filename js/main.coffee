# require bootloader
require.config

    paths:
        backbone: "../bower_components/backbone/backbone" # amd version
        underscore: "../bower_components/underscore/underscore" # amd version
        jquery: "../bower_components/jquery/dist/jquery" # amd version
        marionette: "../bower_components/marionette/lib/backbone.marionette" # amd version
        "backbone.syphon": "../bower_components/backbone.syphon/lib/backbone.syphon" # amd version
        moment: "../bower_components/moment/moment"
        globalize: "../bower_components/globalize/lib/globalize"
        text: "../bower_components/text/text"
        d3: "../bower_components/d3/d3",
        spin: "../bower_components/spin.js/spin"
        jqueryspin: "../bower_components/spin.js/jquery.spin"
        bootstrap:"../bower_components/bootstrap/dist/js/bootstrap"

    shim:
        bootstrap: ["jquery"]

	require ["config/load", "app" ], (_config, app) -> # ensure that base application settings are loaded before we can call the app.  Templates, settings and jquery plugins
        app.start()