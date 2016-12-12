# msgbus decoupled from app
define ["backbone","backbone.radio"], (Backbone) ->
  # mult-channel msgBus
  appChannel:               Backbone.Radio.channel 'app'    #namespaced channels for better seperation of concerns
  dataChannel:              Backbone.Radio.channel 'data'
  componentChannel:         Backbone.Radio.channel 'component'
