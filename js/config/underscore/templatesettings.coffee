# config underscore templates to use mustache override default global templates to use mustache formated styles {{ xx }}
# {[ if(true) ]}
define ['underscore'], ( _ ) ->
    _.templateSettings =
        evaluate: /\{\[([\s\S]+?)\]\}/g
        interpolate: /\{\{(.+?)\}\}/g