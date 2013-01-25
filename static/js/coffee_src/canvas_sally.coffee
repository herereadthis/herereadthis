# define ["jquery"], ( $ ) ->
define (require) ->
	$ = require "jquery"
	exports = {}
	gVars = {}
	# name of actual file here
	moduleName = "canvas_sally"
	em = parseInt $("body").css("font-size"), 10


	makeCircle = ( context, _this, settings) ->
        # circle is drawn from center of canvas
        center = 
            x: _this.width() / 2
            y: _this.width() / 2
        radius = _this.width() / 2
        context.beginPath()
        context.arc(center.x, center.y, radius, 0, 2 * Math.PI, false)
        context.fillStyle = settings.color
        context.fill()
        # context.strokeStyle = canVars.color
        # context.stroke();



	positionCanvas = ( _this, settings ) ->
		_parent = _this.parent()
		parentLeftPad = parseInt(_this.parent().css("padding-left"), 10)
		_parent.css
			"padding-left": ""

		parentWidth = _parent.width()
		parentPad = settings.pad * em
		canvasWidth = Math.round settings.width * parentWidth / 100
		# console.log parentWidth, parentPad, canvasWidth
		# a shift in padding if canvas is abolutely positioned
		canvasPosition = _this.css "position"


		if canvasPosition is "absolute"
		    if settings.float is "left"
		        absAdjust = parseInt _this.css("left"),10
		        _parent.css
		            "padding-left": 0
		    else
		        absAdjust = 0

		    # set a min height, based on top padding of parent and top position of canvas
		    parentTopPad = parseInt _parent.css("padding-top"),10
		    absTop = parseInt(_this.css("top"),10) || 0
		    parentMinHeight = canvasWidth - parentTopPad + absTop
		    _parent.css
		        "min-height": parentMinHeight
		else
		    absAdjust = 0
		_this.attr(
		    "width": canvasWidth
		    "height": canvasWidth
		).css
		    "float": settings.cssFloat

		_this.siblings().css {
		    "margin-left": parentPad + canvasWidth + absAdjust - parentLeftPad
		}


	# exports.init = ( element ) ->


	makeItHappen = ( element ) ->
		em = parseInt $("body").css("font-size"), 10
		settings = 
			id: element.attr "id"
			color: element.data "color"
			shape: element.data "shape"
			width: element.data "width"
			cssFloat: element.data("css-float") or "none"
			pad: element.data("pad") or 0

		canvas = document.getElementById(settings.id)
		context = canvas.getContext "2d"

		# if $("html").hasClass "no-touch"
		positionCanvas $(element), settings
		if settings.shape is "circle"
            makeCircle context, $(element), settings

		$(window).resize () ->
            # if $("html").hasClass "no-touch"
            positionCanvas $(element), settings
			if settings.shape is "circle"
                makeCircle context, $(element), settings


	exports.init = ( _this ) ->
		# _this is a jQuery object
		if _this != undefined
			makeItHappen _this
		else
			element = $("body").find("[data-module=\"#{ moduleName }\"]")
			element.each () ->
				makeItHappen $(@)



	exports


