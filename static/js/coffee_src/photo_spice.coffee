# define ["jquery"], ( $ ) ->
define (require) ->
	$ = require "jquery"
	Modernizr = require "Modernizr"
	ResizeFu = require "resize_fu"
	# NextArrow = require "next_arrow"
	exports = {}
	psVars =
		fade:
			low: 0.15
			high: 0.75
		fadebarID: "ps_fadebar"
		fadebar: "#ps_fadebar"
		h2:
			ml1: -550
			ml2: 410
		sectionMargin:
			top: 0
			bottom: 0
		peekNext: 3
	
	# name of actual file here
	moduleName = "photo_spice"
	em = parseInt $("body").css("font-size"), 10
	_window = $(window)


	checkScroll = ( _this ) ->
		offset = _this.offset()
		# place is > 0 if any bit of the article is visible in browser.
		place = Math.round _this.height() + offset.top - _window.scrollTop()
		if place > 0
			pc = (_window.height() - offset.top + _window.scrollTop()) / _window.height()
			_h2 = _this.find "h2"
			# basically, what happens in this section is when the article comes into view, the top part changes
			# Starts off with a full opacity top bar, black title
			if pc <= psVars.fade.low
				$(psVars.fadebar).css "opacity",1
				_h2.css
					"opacity":0
					"color":"#000"
			# transisitons within tolerances as percentage
			# e.g. if psVars.fade = {0.15,0.5}, then the transition occurs when top of article is within
			# 15% - 50% from the bottom of the browser
			else if pc < psVars.fade.high
				opacity = Math.round(100 * (1 - ((pc - psVars.fade.low) / (psVars.fade.high - psVars.fade.low)))) / 100
				# color of title is greyscale, built on hexadecimal web color
				getRGB = Math.round((1 - opacity) * 255)
				rgb = "rgb(#{ getRGB },#{ getRGB },#{ getRGB })"
				# console.log opacity, getRGB, rgb
				$(psVars.fadebar).css "opacity",opacity
				inverseOp = 1 - opacity

				range = psVars.h2.ml2 - psVars.h2.ml1
				gRange = ((1 - opacity) * range) + psVars.h2.ml1
				# console.log gRange
				_h2.css
					"opacity":inverseOp
					"color":rgb


			# finishes without top bar, and white title
			else
				$(psVars.fadebar).css "opacity",0
				_h2.css
					"opacity":1
					"color":"#FFF"


	makeMinHeight = ( _this ) ->
		minHeight = parseInt(_this.css("min-height"), 10) / em
		_section = _this.find "section"
		# console.log minHeight, "???"
		_section.css
			"min-height": "#{ minHeight - psVars.sectionMargin.top - psVars.sectionMargin.bottom }em"

	makeItHappen = ( _this ) ->
		# resize header to fit page, accordingly
		ResizeFu.init _this
		console.log "made it happen for photo_spice"
		# set top and bottom paddings of section based on css
		_section = _this.find "section"
		psVars.sectionMargin = 
			top: parseInt(_section.css("margin-top"), 10) / em
			bottom: parseInt(_section.css("margin-bottom"), 10) / em
		makeMinHeight _this

		#make the fadebar
		_this.append $("<span />").attr("id",psVars.fadebarID)
		checkScroll _this

		#make the arrow leading to this
		# NextArrow.init _this

		_window.scroll () ->
			checkScroll _this

		_window.resize () ->
			makeMinHeight _this


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


