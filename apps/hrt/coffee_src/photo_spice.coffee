# define ["jquery"], ( $ ) ->
define (require) ->
    $ = require "jquery"
    Modernizr = require "Modernizr"
    # ResizeFu = require "resize_fu"
    # NextArrow = require "next_arrow"
    exports = {}
    # name of actual file here
    moduleName = "photo_spice"
    _window = $(window)
    gVars = 
        # em-value of page
        em: parseFloat $("body").css("font-size"), 10
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
        # expressed as a 0 < percentage < 1, spacing between edge of window and sides of photo section
        # override locally with html data-photospice-thresh-sides="0.##"
        threshSides: 0.05
        # same as above, but for top and bottom edges
        # override locally with html data-photospice-thresh-tb="0.##"
        threshTB: 0.05
        # overhang of photoSpice, to prevent peek-through of next article in case of over-scrolling, EMs
        overhang: 5
        # phi is ratio of height to width of photo section. Attempt to fit
        # override locally with html data-photospice-max-ratio="###" where ### is float
        # maxRatio: (1 + Math.sqrt(5)) / 2 - 1
        maxRatio: 1/2
        # maxRatio: 1/1.85
        # width of article title in relation to section, expressed as percentage
        # override: data-photo-spice-title-width="0.##"
        titleWidth: 0.1475
    


    # checkscroll controls visual transitions as user scrolls
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


    positionTitle = ( _this, winDim, lVars ) ->
        # alert lVars.titleWidth * winDim.adjusted.width
        _title = _this.find "h2"
        titleWidth = Math.round lVars.titleWidth * winDim.adjusted.width
        fontAdjust = 0.45
        _title.css
            "width": titleWidth
            "margin-left": (winDim.adjusted.width / 2) - titleWidth
            "top": Math.round winDim.adjusted.marginTop
            "font-size": Math.round fontAdjust * titleWidth



    makeMinHeight = ( _this, lVars ) ->
        # to make photo section, first get window dimensions
        winWidth = do _window.width
        winHeight = do _window.height
        mTop = lVars.threshTB * winHeight
        mLeft = lVars.threshSides * winHeight
        winDim =
            width: winWidth
            height: winHeight
            margin:
                top: mTop
                left: mLeft
            adjusted:
                marginTop: 0
                width: winWidth - 2 * mLeft
                height: winHeight - 2 * mTop

        # console.log winDim
        # console.log winDim.adjusted.height / winDim.adjusted.width
        _section = _this.find "section"
        # if the window is too wide, favor adusted height
        if winDim.adjusted.height / winDim.adjusted.width <= lVars.maxRatio
            winDim.adjusted.width = winDim.adjusted.height / lVars.maxRatio
            winDim.adjusted.marginTop = winDim.margin.top
        # else if window is too narrow, favor adjusted width
        else
            winDim.adjusted.height = winDim.adjusted.width * lVars.maxRatio
            winDim.adjusted.marginTop = (winDim.height - winDim.adjusted.height) / 2

        _section.css
            "width": Math.round winDim.adjusted.width
            "height": Math.round winDim.adjusted.height
            "margin-top": Math.round winDim.adjusted.marginTop
            "margin-bottom": Math.round lVars.overhang * gVars.em + winDim.adjusted.marginTop

        positionTitle _this, winDim, lVars



    makeItHappen = ( _this ) ->
        # resize header to fit page, accordingly
        # ResizeFu.init _this
        # console.log "made it happen for photo_spice"
        thisData = {}
        if _this.data("photospice-thresh-sides") != undefined
            thisData.threshSides = parseFloat _this.data("photospice-thresh-sides"), 10
        if _this.data("photospice-thresh-tb") != undefined
            thisData.threshTB = parseFloat _this.data("photospice-thresh-tb"), 10
        if _this.data("photospice-max-ratio") != undefined
            thisData.maxRatio = parseFloat _this.data("photospice-max-ratio"), 10
        if _this.data("photospice-overhang") != undefined
            thisData.overhang = parseInt _this.data("photospice-overhang"), 10
        if _this.data("photospice-max-ratio") != undefined
            thisData.maxRatio = parseFloat _this.data("photospice-max-ratio"), 10
        if _this.data("photospice-title-width") != undefined
            thisData.titleWidth = parseFloat _this.data("photospice-title-width"), 10


        lVars = {}
        lVars.threshSides = if thisData.threshSides? then thisData.threshSides else gVars.threshSides
        lVars.threshTB = if thisData.threshTB? then thisData.threshTB else gVars.threshTB
        lVars.overhang = if thisData.overhang? then thisData.overhang else gVars.overhang
        lVars.maxRatio = if thisData.maxRatio? then thisData.maxRatio else gVars.maxRatio
        lVars.titleWidth = if thisData.titleWidth? then thisData.titleWidth else gVars.titleWidth
        # set top and bottom paddings of section based on css
        # _section = _this.find "section"
        # gVars.sectionMargin = 
        #   top: parseInt(_section.css("margin-top"), 10) / em
        #   bottom: parseInt(_section.css("margin-bottom"), 10) / em
        makeMinHeight _this, lVars

        #make the fadebar
        _this.append $("<span />").attr("id",gVars.fadebarID)
        checkScroll _this

        #make the arrow leading to this
        # NextArrow.init _this

        _window.scroll () ->
            checkScroll _this

        _window.resize () ->
            makeMinHeight _this, lVars


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


