require.config

    paths:
        jquery: "../bower_components/jquery/dist/jquery" 
        underscore: "../bower_components/underscore/underscore" 
        backbone: "../bower_components/backbone/backbone" 
        marionette: "../bower_components/marionette/lib/backbone.marionette" 
        "backbone.syphon": "../bower_components/backbone.syphon/lib/backbone.syphon" 
        "backbone.radio": "../bower_components/backbone.radio/build/backbone.radio" 
        moment: "../bower_components/moment/moment"
        globalize: "../bower_components/globalize/lib/globalize"
        text: "../bower_components/text/text"
        d3: "../bower_components/d3/d3",
        spin: "../bower_components/spin.js/spin"
        jqueryspin: "../bower_components/spin.js/jquery.spin"
        bootstrap:"../bower_components/bootstrap/dist/js/bootstrap"

    shim:
        bootstrap:  ["jquery"]
        spin:       ["jquery"]
        jqueryspin: ["jquery"]

	require ["config/load", "entities/load", "components/loading/controller", "apps/load", "app" ], (_config, _entities,base, modules, app) -> 
        # ensure that base application settings are loaded before we can call the app.  
        # Templates, settings and jquery plugins
        console.log modules.startEvents
        app.start
            startEvents: modules.startEvents