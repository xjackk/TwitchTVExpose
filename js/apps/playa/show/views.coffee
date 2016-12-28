define ['apps/playa/show/templates', 'marionette'], (Templates, Mn) ->

    Player: class Player extends Mn.View
        template: _.template(Templates.player)
        ui:
            panelbody:      ".panel-body"
        
        modelEvents:
            "change:video_height": "render"

        onDomRefresh: ->
            pw 	= @ui.panelbody.outerWidth(false)
            ph = Math.floor ((pw-30) * 9 / 16)

            console.log "Video Height: #{@model.get 'video_height'}"

            @model.set "video_height", ph
            console.log "Video Height: AFTER RESIZE: #{@model.get 'video_height'}"
            console.log "Panel Width (var): #{pw}"



    User: class User extends Mn.View
        template: _.template(Templates.user)

    Chat: class Chat extends Mn.View
        template: _.template(Templates.chat)

    Layout: class Layout extends Mn.View
        template: _.template(Templates.layout)
        regions:
            playerRegion: "#player-region"
            userRegion: "#user-region"
            chatRegion: "#chat-region"

        onRender: ->
            @showChildView "playerRegion", new Player
                model: @model
    