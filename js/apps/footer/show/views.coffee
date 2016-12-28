# show footer views.
define ['marionette', 'apps/footer/show/templates'], (Mn, Templates) ->

    FooterView: class ShowFooterView extends Mn.View
        el: "#footer-region"
        template: _.template(Templates.footer)


        modelEvents:
            "change" : "render"