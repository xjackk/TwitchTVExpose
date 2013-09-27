define ['apps/playa/show/templates', 'views/_base', 'swf'], (Templates, AppView, swf) ->

    Player: class Player extends AppView.ItemView
        template: _.template(Templates.player)
        ui:
            panelbody: ".panel-body"

        # initialize: (options) ->
        #    console.log "resizing..."
        #    $(window).on 'resize', @onShow


        onShow: ->
            $panel = @$(".panel-body")
            $width 	= @ui.panelbody.outerWidth(false)
            $height = Math.floor $width * 9 / 16
            flashvars=false
            params =
                allowFullScreen: "true"
                wmode:  "transparent"
                allowScriptAccess: "always"
                allowNetworking: "all"
                flashvars: "hostname=www.twitch.tv&channel=#{@model.get("channel").display_name}&start_volume=15&auto_play=true&client_id=hqxyqc9bf41e6grm6txrsdcwncoxavz&res=720p"

            swf.embedSWF("https://www-cdn.jtvnw.net/widgets/live_embed_player.swf?channel=#{@model.get("channel").display_name}&auto_play=true", "twitchplayer", $width, $height, "9", null, flashvars, params, {});


    User: class User extends AppView.ItemView
        template: _.template(Templates.user)

    Chat: class Chat extends AppView.ItemView
        template: _.template(Templates.chat)

    Layout: class Layout extends AppView.Layout
        template: _.template(Templates.layout)
        regions:
            playerRegion: "#player-region"
            userRegion: "#user-region"
            chatRegion: "#chat-region"