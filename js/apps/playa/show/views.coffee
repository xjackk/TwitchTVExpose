define ['apps/playa/show/templates', 'views/_base'], (Templates, AppView) ->

    Player: class Player extends AppView.ItemView
        template: _.template(Templates.player)

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