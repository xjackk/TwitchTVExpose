define ["backbone", "msgbus",], (Backbone, msgBus ) ->
    # this _fetch is our private property added to overridden config backbone sync

	class User extends Backbone.Model

	class UsersCollection extends Backbone.Collection
		model: User

	API =
		setCurrentUser: (currentUser) ->
			new User currentUser

	msgBus.reqres.setHandler "set:current:user", (currentUser) ->
		API.setCurrentUser currentUser