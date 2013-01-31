# define ["jquery"], ( $ ) ->
define (require) ->
	$ = require "jquery"
	Modernizr = require "Modernizr"
	ResizeFu = require "resize_fu"
	exports = {}
	gVars = {}
	# name of actual file here
	moduleName = "make_it_new"
	em = parseInt $("body").css("font-size"), 10
	_window = $(window)


	makeShape = ( _this ) ->
		pt = _this.css("padding-top").split "px"
		padTop =  pt[0]
		pb = _this.css("padding-bottom").split "px"
		padBot =  pb[0]
		# newHeight = _this.outerHeight() - padTop - padBot
		bgSize = _this.css("background-size").split " "
		newBgSize = "#{ parseInt bgSize[0], 10 }% #{ _this.height() }px"
		newBgPos = "0% #{ padTop / em }em"
		_this.css
			"background-size": newBgSize
			"background-position": newBgPos

	makeItHappen = ( _this ) ->
		# resize header to fit page, accordingly
		ResizeFu.init _this
		# console.log "made it happen for #{  moduleName }"
		# set top and bottom paddings of section based on css
		_section = _this.find "section"
		makeShape _this



		_window.resize () ->
			makeShape _this


		# convert the padding from ResizeFu into a straight up min-height



	exports.init = ( _this ) ->
		# _this is a jQuery object
		if _this != undefined
			makeItHappen _this
		else
			element = $("body").find("[data-module=\"#{ moduleName }\"]")
			element.each () ->
				makeItHappen $(@)

	exports


