# define ["jquery"], ( $ ) ->
define (require) ->
	$ = require "jquery"
	Modernizr = require "Modernizr"
	ResizeFu = require "resize_fu"
	exports = {}
	gVars =
		fade:
			low: 0.15
			high: 0.61803
		fadebarID: "ps_fadebar"
		fadebar: "#ps_fadebar"
		h2:
			ml1: -550
			ml2: 410
	
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
			if pc <= gVars.fade.low
				$(gVars.fadebar).css "opacity",1
				_h2.css
					"opacity":0
					"color":"#000"
			# transisitons within tolerances as percentage
			# e.g. if gVars.fade = {0.15,0.5}, then the transition occurs when top of article is within
			# 15% - 50% from the bottom of the browser
			else if pc < gVars.fade.high
				opacity = Math.round(100 * (1 - ((pc - gVars.fade.low) / (gVars.fade.high - gVars.fade.low)))) / 100
				# color of title is greyscale, built on hexadecimal web color
				getRGB = Math.round((1 - opacity) * 255)
				rgb = "rgb(#{ getRGB },#{ getRGB },#{ getRGB })"
				# console.log opacity, getRGB, rgb
				$(gVars.fadebar).css "opacity",opacity
				inverseOp = 1 - opacity

				range = gVars.h2.ml2 - gVars.h2.ml1
				gRange = ((1 - opacity) * range) + gVars.h2.ml1
				# console.log gRange
				_h2.css
					"opacity":inverseOp
					"color":rgb


			# finishes without top bar, and white title
			else
				$(gVars.fadebar).css "opacity",0
				_h2.css
					"opacity":1
					"color":"#FFF"


	makeMinHeight = ( _this ) ->
		minHeight = parseInt(_this.css("min-height"), 10) / em
		_section = _this.find "section"
		# console.log minHeight, "???"
		_section.css
			"min-height": "#{ minHeight }em"

	makeItHappen = ( _this ) ->
		# resize header to fit page, accordingly
		ResizeFu.init _this
		console.log "made it happen for photo_spice"
		makeMinHeight _this

		#make the fadebar
		_this.append $("<span />").attr("id",gVars.fadebarID)

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

