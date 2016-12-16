# list currency views
define ['views/_base', 'spin', 'jqueryspin'], (AppView, Templates) ->
	LoadingView: class LoadingView extends AppView.ItemView
		template: false #_.template(Templates.main)
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