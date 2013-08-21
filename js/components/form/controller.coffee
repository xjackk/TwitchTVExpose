# form component controller
define ["msgbus", "backbone", "controller/_base", "components/form/views", "backbone.syphon"], (msgBus, Backbone, AppController, FormWrapper) ->
    # the module API will pass in the glogal collection of ccys
	class FormController extends AppController

		initialize: (options = {}) ->
			@contentView = options.view
			@formLayout = @getFormLayout options.config
			@listenTo @formLayout, "show", @formContentRegion
			@listenTo @formLayout, "form:submit", @formSubmit
			@listenTo @formLayout, "form:cancel", @formCancel

		formCancel: ->
			@contentView.triggerMethod "form:cancel"

		formSubmit: ->
			data = Backbone.Syphon.serialize @formLayout
			if @contentView.triggerMethod("form:submit", data) isnt false
				model = @contentView.model
				collection = @contentView.collection
				@processFormSubmit data, model, collection

		processFormSubmit: (data, model, collection) ->
			model.save data,
				collection: collection

		onClose: ->
			#console.log "onClose", @
		
		formContentRegion: ->
			@region = @formLayout.formContentRegion
			@show @contentView

		getFormLayout: (options = {}) ->
			config = @getDefaultConfig _.result(@contentView, "form")
			_.extend config, options
			
			buttons = @getButtons config.buttons

			new FormWrapper
				config: config
				model: @contentView.model
				buttons: buttons

		getDefaultConfig: (config = {}) ->
			_.defaults config,
				footer: true
				focusFirstInput: true
				errors: true
				syncing: true
		
		getButtons: (buttons = {}) ->
			msgBus.reqres.request("form:button:entities", buttons, @contentView.model) unless buttons is false

	msgBus.reqres.setHandler "form:wrapper", (contentView, options = {}) ->
		throw new Error "No model found inside of form's contentView" unless contentView.model
		formController = new FormController
			view: contentView
			config: options
		formController.formLayout