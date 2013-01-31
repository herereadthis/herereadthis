# define ["jquery"], ( $ ) ->
define (require) ->
	$ = require "jquery"
	Modernizr = require "Modernizr"
	NextArrow = require "next_arrow"
	ResizeFu = require "resize_fu"
	NextArrow = require "next_arrow"
	# NextArrow = require "next_arrow"
	exports = {}
	gVars = {}
	# name of actual file here
	moduleName = "head_more"
	em = parseInt $("body").css("font-size"), 10


	# adds a little more intuitive action for user: the link acts for the whole list item
	# E.G. <li>lorem ipsum <a href="/foo">sit dolar</a> amet</li>,
	# if user clicks on lorem ipsum, is redirected to "/foo"
	makeSocialClick = ( _this ) ->
		_this.on "click","li", (e) ->
			_links = $(@).find "a"
			# only works if there is only one link in the list item
			if _links.length is 1
				href = _links.attr "href"
				window.location.href = href


	makeItHappen = ( _this ) ->
		# resize header to fit page, accordingly
		ResizeFu.init _this
		makeSocialClick _this.find("aside")

		#make the arrow leading to this
		NextArrow.init _this


	exports.init = ( _this ) ->
		# _this is a jQuery object
		if _this != undefined
			makeItHappen _this
		else
			element = $("body").find("[data-module=\"#{ moduleName }\"]")
			element.each () ->
				makeItHappen $(@)

	exports


