# load base config before app
define [
    "text"
    "jquery"
    "config/jquery/jquery"            		#custom jquery functions/plugins etc.
    "config/underscore/templatesettings"	#underscore template config
    "config/backbone/sync"					#custom sync handling to trigger before send and complete events to better support form/controller
    "config/marionette/application"		#marionette application overrides
    "config/marionette/templatecache"		#marionette templatecache config
    "components/loading/controller"  
    "bootstrap"        	                #twitter bootstrap
    "globalize"
], ->