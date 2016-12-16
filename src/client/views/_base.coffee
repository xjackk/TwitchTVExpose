# override marionette views for any of our application specific needs
define ["marionette"], (Marionette) ->
  _remove = Marionette.View::remove

  _.extend Marionette.View::,
    addOpacityWrapper: (init = true) ->
        @$el.toggleWrapper
            className: "opacity"
        , init

    # @options not supported in backbone v1.1.0
    # setInstancePropertiesFor: (args...) ->
    #    for key, val of _.pick(@options, args...)
    #        @[key] = val

    remove: (args...) ->
        #console.log "removing", @
        if @model?.isDestroyed?()
            wrapper = @$el.toggleWrapper
                className: "opacity"
                backgroundColor: "red"

            wrapper.fadeOut 400, ->
                $(@).remove()

            @$el.fadeOut 400, =>
                _remove.apply @, args
        else
            _remove.apply @, args


  View:     Marionette.View

  ItemView: Marionette.ItemView

  CollectionView: Marionette.CollectionView

  CompositeView: Marionette.CompositeView

  LayoutView: Marionette.LayoutView