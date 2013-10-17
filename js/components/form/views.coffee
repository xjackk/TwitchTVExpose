# list currency views
define ['components/form/templates', 'views/_base'], (Templates, AppView) ->

    class FormWrapper extends AppView.Layout
        template: _.template(Templates.form)
        tagName: "form"
        className: "well clearfix"
        attributes: ->
            "data-type": @getFormDataType()

        regions:
            formContentRegion: "#form-content-region"

        ui:
            buttonContainer: "ul.inline"

        triggers:
            "submit": "form:submit"
            "click [data-form-button='cancel']" : "form:cancel"

        modelEvents:
            "change:_errors": "changeErrors"
            "sync:start": "syncStart"
            "sync:stop": "syncStop"

        initialize: (options={}) ->
            {@config, @buttons} = options
            #@setInstancePropertiesFor "config", "buttons"

        serializeData: ->
            footer: @config.footer
            buttons: @buttons?.toJSON() ? false

        onShow: ->
            _.defer =>
                @focusFirstInput() if @config.focusFirstInput
                @buttonPlacement() if @buttons

        buttonPlacement: ->
            @ui.buttonContainer.addClass "pull-#{@buttons.placement}"

        focusFirstInput: ->
            @$(":input:visible:enabled:first").focus()

        getFormDataType: ->
            if @model.isNew() then "new" else "edit"

        changeErrors: (model, errors, options) ->
            if @config.errors
                if _.isEmpty(errors) then @removeErrors() else @addErrors errors

        removeErrors: ->
            @$(".error").removeClass("error").find("small").remove()

        addErrors: (errors = {}) ->
            for name, array of errors
                @addError name, array[0]

        addError: (name, error) ->
            el = @$("[name='#{name}']")
            sm = $("<small>").text(error)
            el.after(sm).closest(".row").addClass("error")

        syncStart: (model) ->
            console.log "syncStart"
            @addOpacityWrapper() if @config.syncing

        syncStop: (model) ->
            console.log "syncStop"
            @addOpacityWrapper(false) if @config.syncing
