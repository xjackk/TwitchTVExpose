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

    templateHelpers: ->

      linkTo: (name, url, options = {}) ->
        _.defaults options,
            external: false

        url = "#" + url unless options.external

        "<a href='#{url}'>#{@escape(name)}</a>"


  ItemView: class AppItemView extends Marionette.ItemView

  CollectionView: class AppCollectionView extends Marionette.CollectionView
    #childViewEventPrefix: "childview"

  CompositeView: class AppCompositeView extends Marionette.CompositeView
    #childViewEventPrefix: "childview"

  LayoutView: class AppLayoutView extends Marionette.LayoutView
