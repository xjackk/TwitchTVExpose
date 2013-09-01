# list currency views
define ['apps/about/show/templates', 'views/_base', 'd3'], (Templates, AppView) ->

    About: class _item extends AppView.ItemView
        template: _.template(Templates.about)

    Layout: class DataVisLayout extends AppView.Layout
        template: _.template(Templates.layout)
        regions:
            aboutRegion: "#about-region"
            bookRegion: "#book-region"

