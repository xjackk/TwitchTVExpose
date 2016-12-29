# load base config before app
define [
 "config/underscore/templatesettings"	#underscore template config
 "config/marionette/templatecache"		#marionette templatecache config
 "config/backbone/sync"					#promise based fetch; handle 'when:fetched' event
 "entities/twitchtv"
 "entities/appstate"
 "entities/author"
 "entities/reference"
 "entities/oss"
 "bootstrap"        	                #twitter bootstrap
 "globalize"
], ->