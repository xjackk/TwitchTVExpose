# list currency views
define ['marionette', 'components/loading/templates'], (Marionette, Templates) ->
	Loading: class _LoadingView extends Marionette.ItemView
		template: _.template(Templates.main)
		className: "loading-container"

		onShow: ->
			opts = @_getOptions()
			@$el.spin opts

		onClose: ->
			@$el.spin false

		_getOptions: ->
			lines: 10
			length: 6
			width: 2.5
			radius: 7
			corners: 1
			rotate: 9
			direction: 1
			color: '#000'
			speed: 1
			trail: 60
			shadow: false
			hwaccel: true
			className: 'spinner'
			zIndex: 2e9
			top: 'auto'
			left: 'auto'
