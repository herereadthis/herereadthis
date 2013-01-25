# define ["jquery"], ( $ ) ->
define (require) ->
	$ = require "jquery"
	Modernizr = require "Modernizr"
	ResizeFu = require "resize_fu"
	exports = {}
	gVars = {}
	em = parseInt $("body").css("font-size"), 10


	makeSocialClick = ( _this ) ->
		_this.on "click","li", (e) ->
			_links = $(@).find "a"
			if _links.length is 1
				href = _links.attr "href"
				window.location.href = href

	exports.init = ( _this ) ->
		# resize header to fit page, accordingly
		ResizeFu.init _this
		# reset the paddings caused by ResizeFu to maintain visual height

		makeSocialClick _this.find("aside")




	exports


