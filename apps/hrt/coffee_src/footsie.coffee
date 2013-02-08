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
        # window height is actually theoretical; if not window's height, then a height to fit content
        winWidth: do _window.width
        winHeight: do _window.height
        # showing > 0 if any part of the footer is showing
        showing: 0

    # the golden ratio
    phi = (1 + Math.sqrt(5)) / 2
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

    # variables for the rileyKiss background
    riley =
        # divide the top and lower portions of footer
        cutoffRatio: 2 / 3
        # space between the two shapes, EMs
        nudge: 0.4 * gVars.em
        # ratio of radius of circle to width of window
        magicFactor: 1.5
        magicMobile: 1

    sects =
        # threshold for top and bottom pads of last section of footer
        endThresh: 4 * gVars.em
        # popups, time in milliseconds to fade in or out
        windowFade: 300







    # rileyKiss will create the circle fields, must be recreated at each instance of window resize
    rileyKiss = ( _this ) ->
        # create the canvas
        canvas = document.createElement "canvas"
        # canvas.width = fv.bgWidth
        canvas.width = gVars.winWidth
        canvas.height = gVars.winHeight
        context = canvas.getContext "2d"  
        console.log "winHeight is #{gVars.winHeight}!","winWidth is #{gVars.winWidth}!"

        # cutoff = Math.round (phi - 1) * gVars.winHeight
        cutoff = riley.cutoffRatio * gVars.winHeight
        # we will have to revisit inverse cut in case the bottom portion of the footer is larger than the cut
        inverseCut = gVars.winHeight - cutoff

        arcVar = {}
        arcVar.x = (2 - phi) * gVars.winWidth
        arcVar.radius = riley.magicFactor * gVars.winWidth
        arcVar.y = 0 - arcVar.radius + cutoff - riley.nudge

        do context.beginPath
        context.arc arcVar.x, arcVar.y, arcVar.radius, Math.PI * 0.25, Math.PI * 0.75, false
        context.lineTo 0, cutoff
        context.lineTo gVars.winWidth, cutoff
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


    # footSize = ( _this ) ->
    #     gVars.winWidth = do _window.width
    #     gVars.winHeight = do _window.height

    #     _this.css
    #         "min-height": Math.round gVars.winHeight * 1
    #         "height":600


    scrollMath = ( _this, winHtLessOffset ) ->
        gVars.showing = _window.scrollTop() + winHtLessOffset



    makeSections = ( _this ) ->
        sections = _this.find "section"

        _begin = $(sections[0])
        _end = $(sections[sections.length - 1])
        # theretical height of end seciton
        endHt = (1 - riley.cutoffRatio) * gVars.winHeight

        endSize = {}
        endSize.height = Math.round _end.height()
        minEndHeight = endSize.height + 2 * sects.endThresh
        toFull = Math.round minEndHeight / (1 - riley.cutoffRatio)
        # if the minimum height allowance of last section is less than given height
        if minEndHeight <= endHt
            maybeHt = do _window.height
            # because makeSections activates multiple times, check if resizing to ideal height won't break it
            if toFull > maybeHt
                gVars.winHeight = toFull
            else
                gVars.winHeight = do _window.height
            endSize.padTop = Math.round (endHt - endSize.height) / 2
        # else resize footer to fit last section
        else
            gVars.winHeight = toFull
            endSize.padTop = sects.endThresh


        # actual height of beginning section requires reset
        _begin.css
            "height":""
        sectHts = []
        for i,k in sections
            if k < sections.length - 1
                sectHts[k] = []
                sectHts[k].push $(i).height()
        diffHt = Math.round gVars.winHeight - _window.height()
        sectHts[0][1] =  Math.round((gVars.winWidth / riley.magicFactor) / 10)
        sectHts[1][1] = Math.round((gVars.winWidth / riley.magicFactor) / 20)

        beginHt = Math.round riley.cutoffRatio * gVars.winHeight

        # if Modernizr.touch is false
        #     for i, k in sectHts
        #         theoryPad = Math.round ((beginHt - i[0] - i[1]) / 2) - sects.topMinPad
        #         i.push theoryPad
        #         if diffHt is 0
        #             if i[2] > 0
        #                 i.push theoryPad
        #             else
        #                 i.push sects.topMinPad
                # which means size of footer is greater than window Height




        _this.css
            "min-height": gVars.winHeight

        if diffHt > 0 and Modernizr.touch is false
            _begin.css
                "height": beginHt - diffHt
                "padding-top": diffHt
            _begin.find("h3:first-of-type").css
                "padding-top": 0
            _begin.next().css
                "padding-top": diffHt
            _begin.next().find("h3:first-of-type").css
                "padding-top": 0
        else
            _begin.css
                "height": Math.round riley.cutoffRatio * gVars.winHeight

        _end.css
            "padding-top": endSize.padTop

    # creates a mail to ref client side, based on data attributes
    obfuscate = ( _this ) ->
        _mail = _this.find $("[data-module=\"obfuscate\"]")
        address = _mail.html()
        subject = _mail.data "obfuscate-subject"
        href = "mailto:#{ address }?subject=#{ subject }"
        # obsArray = []
        # for i, k in href
        #     obsArray.push "&#x#{ i.charCodeAt().toString(16) };"
        # href = obsArray.join("")
        _mail.wrapInner("<a />")
        _mail.find("a").attr
            "href": href




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


    rsaDisplay = ( e, $rpk ) ->
        do e.preventDefault
        if $rpk.attr("aria-expanded") is "false"
            $rpk.fadeIn sects.windowFade, () ->
                $rpk.attr "aria-expanded", true
        else
            $rpk.fadeOut sects.windowFade, () ->
                $rpk.attr "aria-expanded", false

    rsaPublic = ( $this ) ->
        $this.wrapInner $("<a />").attr
            "href":""
        modulus = $this.attr "content"
        exponent = $this.next().html()
        $section = $this.closest "section"
        modArray = []
        cutKey = modulus
        while cutKey.length > 0
            modArray.push cutKey.substring(0,32)
            cutKey = cutKey.substring(32)
        modOut = modArray.join("<br />")
        
        $section.append $("<div />").attr
            "class": "rsa_pub_key"
            "aria-expanded": false
        $rpk = $section.find ".rsa_pub_key"
        $rpk.append $("<a />").html("close [X]").attr
            "href":""
            "title": "Close Window"
        $rpk.append($("<code />").html("Modulus (Hexadecimal):")).append($("<br />"))
        $rpk.append($("<code />").html(modOut)).append($("<br />"))
        $rpk.append($("<code />").html("Exponent (Decimal): #{ exponent }"))

        $this.on "click", "a", (e) ->
            rsaDisplay e, $rpk

        $rpk.on "click", "a", (e) ->
            rsaDisplay e, $rpk


    makeItHappen = ( _this ) ->
        # console.log "init for module #{ moduleName }"
        # make the email:
        obfuscate _this
        if Modernizr.touch is true
            riley.magicFactor = riley.magicMobile

        # set min-height of footer to be height of window or fit sections
        # makeSections _this

        # footer math isn't done until user to bottom of page
        offset = _this.offset()
        # separating this out of the scrollMath function to reduce # of calculations
        winHtLessOffset = _window.height() - offset.top
        _window.scroll () ->
            scrollMath _this, winHtLessOffset
            if gVars.showing > 0 and loadStreaks is true
                loadStreaks = false
                # create the RSA public key window
                rsaPublic _this.find $('[property="cert:modulus"]')
                # make the social links behaviors
                makeSocialClick _this.find ".social_fu"
                # space out the sections
                makeSections _this
                # generate streak noise. It is resource-intensive, so this only gets done once
                footStreaks gVars
                # generate the riley Kiss background
                rileyKiss _this
                console.log "scrolled to footsie"

        _window.resize () ->
            # footSize _this
            gVars.winWidth = do _window.width
            makeSections _this
            if loadStreaks is true
                loadStreaks = false
                footStreaks gVars
            # rileyKiss is done regardless of scrolling position because it must fit the window dimensions
            rileyKiss _this



    exports.init = ( _this ) ->
        # _this is a jQuery object
        if _this != undefined
            makeItHappen _this
        else
            element = $("body").find("[data-module=\"#{ moduleName }\"]")
            element.each () ->
                makeItHappen $(@)

    exports


