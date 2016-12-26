# modular template loading
define (require) ->
    about: require("text!apps/about/show/templates/about.htm")
    layout: require("text!apps/about/show/templates/layout.htm")
    bookTable: require("text!apps/about/show/templates/books.htm")
    bookItem: require("text!apps/about/show/templates/bookitem.htm")
    ossTable: require("text!apps/about/show/templates/oss.htm")
    ossItem: require("text!apps/about/show/templates/ossitem.htm")
