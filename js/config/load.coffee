# load base config before app
define [
 "config/jquery/jquery",            		#custom jquery functions/plugins etc.
 "config/underscore/templatesettings",	#underscore template config
 "config/marionette/templatecache",		#marionette templatecache config
 #"config/marionette/application",		#marionette application overrides
 "config/backbone/sync",					#custom sync handling to trigger before send and complete events to better support form/controller
 #"entities/twitchtv",
 "entities/appstate",
 #"entities/author",
 "entities/reference",
 "entities/oss",
 #"components/form/controller",			#form component
 "components/loading/controller",		#loading component
 #"holderjs",    		                #img placeholders
 "bootstrap",        	                #twitter bootstrap
 "globalize"
], ->