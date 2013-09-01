# modular template loading
define (require) ->
    about: require("text!apps/about/show/templates/about.htm")
    layout: require("text!apps/about/show/templates/layout.htm")
    books: require("text!apps/about/show/templates/books.htm")
    bookitem: require("text!apps/about/show/templates/bookitem.htm")