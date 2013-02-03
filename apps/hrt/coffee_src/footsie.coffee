# define ["jquery"], ( $ ) ->
# images are made with canvas; you can decode them back with http://www.peterdamen.com/base64decode.php
define (require) ->
    $ = require "jquery"
    Modernizr = require "Modernizr"
    exports = {}
    gVars = {}
    # name of actual file here
    moduleName = "footsie"
    _window = $(window)
    gVars = 
        em: parseInt $("body").css("font-size"), 10
        winWidth: ""
        winHeight: ""
        # showing > 0 if any part of the footer is showing
        showing: 0

    # execute the first and only time when user scrolls to footer
    loadStreaks = true
    # if it's size measurement, express as em values
    # otherwise, it's a ratio
    streak = 
        # width of the image, will repeat. The higher the number, the more calculations
        bgWidth: 30
        # width of each streak
        lineWidth: 0.6
        # minimum length of each streak
        lineBaseLen: 4
        # random line of each streak. AKA line length = lineBaseLength + lineRandLength
        lineRandLen: 4
        # baseline opacity for black streaks
        blackBase: 0
        # random increase in opacity for black
        blackRand: 0.015
        # baseline opacity for white streaks
        whiteBase: 0.0
        # random increase in opacity for white
        whiteRand: 0.015

    streakNoise = document.createElement "canvas"



    # rileyKiss will create the circle fields, must be recreated at each instance of window resize
    rileyKiss = ( _this, lVars ) ->
        # create the canvas
        canvas = document.createElement "canvas"
        # canvas.width = fv.bgWidth
        canvas.width = lVars.winWidth
        canvas.height = lVars.winHeight
        context = canvas.getContext "2d"

        phi = (1 + Math.sqrt(5)) / 2

        cutoff = Math.round (phi - 1) * lVars.winHeight
        cutoff = (2/3) * lVars.winHeight
        # we will have to revisit inverse cut in case the bottom portion of the footer is larger than the cut
        inverseCut = lVars.winHeight - cutoff
        nudge = 0.4 * gVars.em
        magicFactor = 1.5

        arcVar = {}
        arcVar.x = (2 - phi) * lVars.winWidth
        arcVar.radius = magicFactor * lVars.winWidth
        arcVar.y = 0 - arcVar.radius + cutoff - nudge



        do context.beginPath
        context.arc arcVar.x, arcVar.y, arcVar.radius, Math.PI * 0.25, Math.PI * 0.75, false
        context.lineTo 0, cutoff
        context.lineTo lVars.winWidth, cutoff
        do context.closePath
        context.fillStyle = "#FFF"
        do context.fill

        # the rileyKiss bg will be layered on top of the streaknoise bg.

        _this.css
            "background-image": "url(#{ canvas.toDataURL("image/png") }), url(#{ streakNoise.toDataURL("image/png") })"
            "background-position": "100% 0, #{ streak.bgWidth * gVars.em }px 100%"



    # footStreaks will greate a streak/noise image, and store it as a global module object, "streakNoise"
    footStreaks = ( lVars ) ->
        # recaulate size measurements with EMs, do it here instead of in loops, to minimize calculations
        fv =
            bgWidth: streak.bgWidth * gVars.em
            lineWidth: streak.lineWidth * gVars.em
            lineBaseLen: streak.lineBaseLen * gVars.em
            lineRandLen: streak.lineRandLen * gVars.em

        # canvas was created as a module global variable, streakNoise
        streakNoise.width = fv.bgWidth
        streakNoise.height = lVars.winHeight
        context = streakNoise.getContext "2d"

        # set line width
        lw = fv.lineWidth
        # iteration starts at half the line width, because the line goes on both
        i = Math.floor lw / 2
        # iteration, for every column = line width, in the background
        while i < fv.bgWidth + 1
            # black, white colors
            color = [
                "rgba(0,0,0,"
                "rgba(255,255,255,"
            ]
            j = 0
            # iteration, for every distance along the line
            while j < lVars.winHeight
                # calculate length of the streak
                strLen = Math.round(Math.random() * fv.lineRandLen) + fv.lineBaseLen
                # return 1 or 0
                io = Math.round Math.random()
                # if io is 1, make black opacity
                bw = Math.round Math.random()
                if bw is 0
                    opacity = Math.round((streak.blackBase + Math.random() * streak.blackRand) * 10000) / 10000
                # else, make white opacity
                else
                    opacity = Math.round((streak.whiteBase + Math.random() * streak.whiteRand) * 10000) / 10000
                # color is color + opacity
                fillColor = "#{ color[bw] }#{ opacity })"
                do context.beginPath
                # begin path of line
                context.moveTo i, j
                # end path
                context.lineTo i, strLen + j
                context.lineWidth = lw
                context.lineCap = "round"
                # add color
                context.strokeStyle = fillColor
                do context.stroke
                # iterate to make next line
                j += strLen
            # iterate to make next column
            i += lw


    footSize = ( _this ) ->
        gVars.winWidth = do _window.width
        gVars.winHeight = do _window.height

        _this.css
            "min-height": Math.round gVars.winHeight * 1


    scrollMath = ( _this, winHtLessOffset ) ->
        gVars.showing = _window.scrollTop() + winHtLessOffset

    makeItHappen = ( _this ) ->
        console.log "init for module #{ moduleName }"


        # set min-height of footer to be height of window
        footSize _this

        # footer math isn't done until user to bottom of page
        offset = _this.offset()
        # separating this out of the scrollMath function to reduce # of calculations
        winHtLessOffset = _window.height() - offset.top
        _window.scroll () ->
            scrollMath _this, winHtLessOffset
            if gVars.showing > 0 and loadStreaks is true
                loadStreaks = false
                # generate streak noise. It is resource-intensive, so this only gets done once
                footStreaks gVars
                # generate the riley Kiss background
                rileyKiss _this, gVars
                console.log "bg for footers made!"

        _window.resize () ->
            footSize _this
            if loadStreaks is true
                loadStreaks = false
                footStreaks gVars
            # rileyKiss is done regardless of scrolling position because it must fit the window dimensions
            rileyKiss _this, gVars



    exports.init = ( _this ) ->
        # _this is a jQuery object
        if _this != undefined
            makeItHappen _this
        else
            element = $("body").find("[data-module=\"#{ moduleName }\"]")
            element.each () ->
                makeItHappen $(@)

    exports


