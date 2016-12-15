# load base config before app
define [
    "jquery",
    "config/jquery/jquery",            		#custom jquery functions/plugins etc.
    "config/underscore/templatesettings",	#underscore template config
    "config/marionette/templatecache",		#marionette templatecache config
    "config/marionette/application",		#marionette application overrides
    "config/marionette/view",		#marionette application overrides
    "config/backbone/sync",					#custom sync handling to trigger before send and complete events to better support form/controller
    "bootstrap",        	                #twitter bootstrap
    "globalize",
    "components/loading/controller"		#loading component
], ->