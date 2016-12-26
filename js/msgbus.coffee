# msgbus decoupled from app
define ["backbone", "backbone.radio"], (Backbone) ->    
    appChannel: new Backbone.Radio.channel "app"
    dataChannel: new Backbone.Radio.channel "data"

