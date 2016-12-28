# load base config before app
define [
 "config/jquery/jquery"            		#custom jquery functions/plugins etc.
 "config/underscore/templatesettings"	#underscore template config
 "config/marionette/templatecache"		#marionette templatecache config
 "config/backbone/sync"					#custom sync handling to trigger before send and complete events to better support form/controller
 "entities/twitchtv"
 "entities/appstate"
 "entities/reference"
 "entities/oss"
 "components/loading/controller"		#loading component
 "bootstrap"        	                #twitter bootstrap
 "globalize"
 "apps/streams/app"
], ->