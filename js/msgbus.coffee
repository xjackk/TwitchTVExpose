# msgbus decoupled from app
define ["backbone.wreqr"], (Wreqr) ->    
    reqres: new Wreqr.RequestResponse()
    commands: new Wreqr.Commands()
    events: new Wreqr.EventAggregator()