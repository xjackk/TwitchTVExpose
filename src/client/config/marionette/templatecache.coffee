define ["backbone","marionette"], (Backbone, Marionette) ->
    
    Marionette.TemplateCache::loadTemplate = (templateId) ->
        # Marionette expects "templateId" to be the ID of a DOM element.
        # But with RequireJS, templateId is actually the full text of the template.
        template = templateId
        
        if not template or template.length is 0
            msg = "Could not find template: '" + templateId + "'"
            err = new Error(msg)
            err.name = "NoTemplateError"
            throw err
        
        template
