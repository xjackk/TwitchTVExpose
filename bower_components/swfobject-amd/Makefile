PATH:=./node_modules/.bin/:${PATH}

swfobject.min.js: swfobject.js
	uglifyjs -nc $< > $@
