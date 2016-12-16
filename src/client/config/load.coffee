# load base config before app
define [
    "text"
    "jquery"
    "config/jquery/jquery"            		#custom jquery functions/plugins etc.
    "config/underscore/templatesettings"	#underscore template config
    "config/marionette/application"		#marionette application overrides
    "config/marionette/templatecache"		#marionette templatecache config
    "bootstrap"        	                #twitter bootstrap
    "globalize"
], ->