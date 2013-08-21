define ["entities/_backbone", "msgbus"], (_Backbone, msgBus ) ->

    class Button extends _Backbone.Model
    	defaults:
    		buttonType: "button"

    class ButtonsCollection extends _Backbone.Collection
    	model: Button

    API =
    	getFormButtons: (buttons, model) ->
    		buttons = @getDefaultButtons buttons, model
    
    		array = []
    		array.push { type: "cancel", className: "btn btn-warning btn-small", text: buttons.cancel } unless buttons.cancel is false
    		array.push { type: "primary", className: "btn btn-success btn-small", text: buttons.primary, buttonType: "submit" } unless buttons.primary is false
    
    		array.reverse() if buttons.placement is "left"
    
    		buttonCollection = new ButtonsCollection array
    		buttonCollection.placement = buttons.placement
    		buttonCollection
    
    	getDefaultButtons: (buttons, model) ->
    		_.defaults buttons,
    			primary: if model.isNew() then "Create" else "Update"
    			cancel: "Cancel"
    			placement: "right"
    
    msgBus.reqres.setHandler "form:button:entities", (buttons = {}, model) ->
    	API.getFormButtons buttons, model