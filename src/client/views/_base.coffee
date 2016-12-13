# override marionette views for any of our application specific needs
define ["backbone", "marionette"], (Backbone, Marionette) ->
	_remove = Marionette.View::remove

	_.extend Marionette.View::,
		addOpacityWrapper: (init = true) ->
			@$el.toggleWrapper
				className: "opacity"
			, init

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

	ItemView: 		class _AppItemView extends Marionette.ItemView

	CollectionView: class _AppCollectionView extends Marionette.CollectionView

	CompositeView: 	class _AppCompositeView extends Marionette.CompositeView

	LayoutView: 	class _AppLayoutView extends Marionette.LayoutView
