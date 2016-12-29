define ['apps/playa/show/templates', 'marionette'], (Templates, Mn) ->

    class PlayerView extends Mn.View
        template: _.template(Templates.player)
        ui:
            panelbody:      ".panel-body"
        
        modelEvents:
            "change:video_height": "render"

        onDomRefresh: ->
            pw 	= @ui.panelbody.outerWidth(false)
            ph = Math.floor ((pw-30) * 9 / 16)

            #console.log "Video Height: #{@model.get 'video_height'}"

            @model.set "video_height", ph
            #console.log "Video Height: AFTER RESIZE: #{@model.get 'video_height'}"
            #console.log "Panel Width (var): #{pw}"



    class UserView extends Mn.View
        template: _.template(Templates.user)

    class ChatView extends Mn.View
        template: _.template(Templates.chat)

    Layout: class PlayerLayout extends Mn.View
        template: _.template(Templates.layout)
        regions:
            playerRegion: "#player-region"
            userRegion: "#user-region"
            chatRegion: "#chat-region"

        onRender: ->
            @showChildView "playerRegion", new PlayerView
                model: @model
            @showChildView "userRegion", new UserView
                model: @model
            @showChildView "chatRegion", new ChatView
                model: @model
  