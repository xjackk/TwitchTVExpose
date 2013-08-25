# load base config before app
define [
 "config/jquery/jquery",            		#custom jquery functions/plugins etc.
 "config/underscore/templatesettings",	#underscore template config
 "config/marionette/templatecache",		#marionette templatecache config
 "config/marionette/application",		#marionette application overrides
 "config/backbone/sync",					#custom sync handling to trigger before send and complete events to better support form/controller
 "entities/_fetch",						#promise based fetch; handle 'when:fetched' event
 "entities/abstract/buttons",    		#button abstract classes (save/cancel) for form/controller
 "entities/twitchtv",
 "components/form/controller",			#form component
 "holderjs",    		                #img placeholders
 "bootstrap",        	                #twitter bootstrap
 "globalize",
 "components/loading/controller",		#loading component
  "entities/appstate",
  "entities/author"
], ->
