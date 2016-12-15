define ['apps/playa/show/templates', 'views/_base'], (Templates, AppView) ->

    Player: class Player extends AppView.ItemView
        template: _.template(Templates.player)
        ui:
            panelbody:      ".panel-body"

        modelEvents:
            "change:video_height": "render"

        onShow: ->
            pw 	= @ui.panelbody.outerWidth(false)
            ph = Math.floor ((pw-30) * 9 / 16)

            console.log "Video Height: #{@model.get 'video_height'}"

            @model.set "video_height", ph
            console.log "Video Height: AFTER RESIZE: #{@model.get 'video_height'}"
            console.log "Panel Width (var): #{pw}"


    User: class User extends AppView.ItemView
        template: _.template(Templates.user)

    Chat: class Chat extends AppView.ItemView
        template: _.template(Templates.chat)

    Layout: class Layout extends AppView.Layout
        template: _.template(Templates.layout)
        regions:
            playerRegion:   "#player-region"
            userRegion:     "#user-region"
            chatRegion:     "#chat-region"