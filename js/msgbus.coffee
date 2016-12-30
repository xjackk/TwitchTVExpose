# msgbus decoupled from app
define ["backbone.radio"], (Radio) ->
    appChannel: Radio.channel "app"