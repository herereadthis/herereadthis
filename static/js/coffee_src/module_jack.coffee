# inspired from http://paceyourself.net/js/util/module-activator.js and modified accordingly
# module jack inspired from http://paceyourself.net/2011/05/14/managing-client-side-javascript-with-requirejs/
define (require) ->
    $ = require "jquery"
    # Modernizr is going to be used for touch capability
    Modernizr = require "Modernizr"
    module = {}

    loadModule = ( domElement ) ->
        element = $ domElement
        # jquery 1.4.3 will take html5 data-attributes
        if Modernizr.touch is false
            moduleName = element.data "module"
        else
            moduleName = element.data "mobile"

        # or basically, will browse things like <div data-module="foo" />
        # and then find foo.js
        require [moduleName], ( module ) ->
            module.init element

    module.execute = ( element ) ->
        element = element or $("html")
        if Modernizr.touch is false
            dataModules = $("[data-module]", element)
        else
            dataModules = $("[data-mobile]", element)
        console.log dataModules
        for i in dataModules
            loadModule i

    module



# define(function(){
#     var module = {};

#     function loadModule(domElement) {
#         var element = $(domElement);
#         var moduleName = element.data("module");

#         require([moduleName], function(module) {
#             module.init(element);
#         });
#     };

#     module.execute = function(element) {
#         var element = element || $("html")
#         var dataModules = $("[data-module]", element);

#         _.each(dataModules, loadModule);
#     };

#     return module;
# });
