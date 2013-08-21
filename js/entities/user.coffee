define ["entities/_backbone", "msgbus",], (_Backbone, msgBus ) ->
    # this _fetch is our private property added to overridden config backbone sync

	class User extends _Backbone.Model

	class UsersCollection extends _Backbone.Collection
		model: User

	API =
		setCurrentUser: (currentUser) ->
			new User currentUser

	msgBus.reqres.setHandler "set:current:user", (currentUser) ->
		API.setCurrentUser currentUser