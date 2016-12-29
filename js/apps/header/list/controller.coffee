# header list controller
define ["apps/header/list/views", "marionette", "entities/appstate"], (Views, Mn, AppState) ->
    class Controller extends Mn.Object
        initialize: ->
            @layout = new Views.Layout
                        
            @listenTo AppState, "change:authState", (model, status) ->
                if status is true
                    loginRegion = @layout.getRegion 'loginRegion'
                    loginRegion.empty()
                else if status is false
                    cv = @layout.getChildView "loginRegion"
                    cv.render()

            @layout.render()