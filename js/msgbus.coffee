# msgbus decoupled from app
define ["backbone","marionette"], (Backbone) ->
  reqres: new Backbone.Wreqr.RequestResponse()
  commands: new Backbone.Wreqr.Commands()
  events: new Backbone.Wreqr.EventAggregator()