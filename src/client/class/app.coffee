# meta modular app data
# for now: name and startEvent are used
define [], ->
  class App
    constructor: (name) ->
      @startEvent = "start:#{name}:app"
      @stopEvent = "stop:#{name}:app" #not used
