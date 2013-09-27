# require bootloader
require.config

    paths:
		# note these are all AMD compliant versions
        jquery: "../bower_components/jquery/jquery" # amd version
        underscore: "../bower_components/underscore-amd/underscore" # amd version
        backbone: "../bower_components/backbone-amd/backbone" # amd version
        "backbone.babysitter": "../bower_components/backbone.babysitter/lib/amd/backbone.babysitter" # amd version
        "backbone.wreqr": "../bower_components/backbone.wreqr/lib/amd/backbone.wreqr" # amd version
        "backbone.syphon": "../bower_components/backbone.syphon/lib/amd/backbone.syphon" # amd version
        marionette: "../bower_components/marionette/lib/core/amd/backbone.marionette" # amd version
        moment: "../bower_components/moment/moment"
        globalize: "../bower_components/globalize/lib/globalize"
        text: "../bower_components/requirejs-text/text"
        d3: "../bower_components/d3/d3",
        swf: "../bower_components/swfobject-amd/swfobject",
        spin: "../bower_components/spin.js/spin"
        jqueryspin: "../bower_components/spin.js/jquery.spin"
        #mockjax: "../bower_components/jquery-mockjax/jquery.mockjax"
        #mockjson: "../bower_components/mockJSON/js/jquery.mockjson"
        #holderjs:"../bower_components/holderjs/holder"
        bootstrap:"../bower_components/bootstrap/dist/js/bootstrap"

    shim:
        #mockjax: ["jquery"]
        #mockjson: ["jquery"]
        bootstrap: ["jquery"]

	require ["config/load", "app" ], (_config, app) -> # ensure that base application settings are loaded before we can call the app.  Templates, settings and jquery plugins
        app.start()