# define ["jquery"], ( $ ) ->
define (require) ->
	$ = require "jquery"
	Modernizr = require "Modernizr"
	exports = {}
	gVars = {}
	em = parseInt $("body").css("font-size"), 10


	myFunction = ( vars ) ->
        console.log "passed variable: #{ vars }"
        console.log "set a global object literal gVars with init, #{ gVars.myVar }"
        console.log "if I define something outside of functions,\nI can call on it,such as body's font-size: #{ em }em"

	exports.init = ( element ) ->
		settings = 
			var1: "foo"
			var2: "bar"
		gVars.myVar = "foobar"

		console.log "resize_fu init!"

		myFunction settings.var1



	exports


