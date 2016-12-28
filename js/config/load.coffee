# load base config before app
define [
 "config/jquery/jquery",            		#custom jquery functions/plugins etc.
 "config/underscore/templatesettings",	#underscore template config
 "config/marionette/templatecache",		#marionette templatecache config
 "config/backbone/sync"					#promise based fetch; handle 'when:fetched' event
 "entities/twitchtv",
 "entities/appstate",
 "entities/author",
 "entities/reference",
 "entities/oss",
 "components/loading/controller",		#loading component
 "bootstrap",        	                #twitter bootstrap
 "globalize"
], ->