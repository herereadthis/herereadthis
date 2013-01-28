# define ["jquery"], ( $ ) ->
# Resize fu is going to attempt to size articles on the page to fit the entire height.
# somethings to consider: the browser is too out of whack to size appropriately.
# for example, on cinema displays, sizing articles to fit page will create wayyy to much empty space
# What about if content is much larger than browser can fit?
# We can set min-height but must consider margins between articles
# Page scaling: return values as EM-values
define (require) ->
    $ = require "jquery"
    Modernizr = require "Modernizr"
    exports = {}
    gVars = {}
    # name of actual file here
    moduleName = "next_arrow"
    moduleClass = ".next_arrow"
    _window = $(window)
    idealWidth = $("body").data "resizefu-ideal-width"
    em = parseInt $("body").css("font-size"), 10
    # fade in, fade out for arrows, unless set by HTML
    gVars =
        tol:
            high: 50
            low: 15
        # rate is based on distance traveled: set how many pixels traveled per millisecond
        scrollSpeed: 1


    scrollMe = ( _this, _arrow) ->
        # opacity of the arrow is a function of tolerances
        # when the next article is mostly out of view, the arrow is full opacity.
        # between certain tolerances, the arrow begins to fade out as more of the next article comes into view
        # when the next article is mostly in view, the arrow is gone.
        # opacity triggers will only happen is arrow is in view
        if _this.outerHeight() - _window.scrollTop() > 0
            pc = (_this.outerHeight() - _window.scrollTop()) / _this.outerHeight()
            # if the next article is mostly out of view
            if pc > gVars.tol.high / 100
                _arrow.css
                    "opacity":1
            # if view of next article is within tolerances
            else if pc > gVars.tol.low / 100
                # opacity is based on going from 100% to 0% in between the tolerances
                opacity = Math.round((pc * 100 - gVars.tol.low) / (gVars.tol.high - gVars.tol.low) * 100) / 100
                _arrow.css
                    "opacity":opacity
            # else if next article is mostly in view
            else
                _arrow.css
                    "opacity":0


    positionMe = ( _this, _arrow ) ->
        horLoc = (_this.data("nextarrow-location") / 100) * idealWidth * em
        arrowEm = _arrow
        thisHt = _this.outerHeight false
        if _window.height() > thisHt
            _arrow.css
                "bottom": thisHt - _window.height()
                "left": horLoc



    makeItHappen = ( _this ) ->
        console.log "arrow for #{ _this.find("h2").html() }"
        _this.append $("<span />").addClass(moduleName).html("&darr;")
        _arrow = _this.find(moduleClass)

        positionMe _this, _arrow

        _window.resize () ->
            positionMe _this, _arrow

        _window.scroll () ->
            scrollMe _this, _arrow

        _arrow.on "click", (e) ->
            nextOffset = $(@).parent().next().offset()
            nextOffTop = Math.round nextOffset.top
            aniSpeed = Math.round nextOffset.top / gVars.scrollSpeed
            console.log aniSpeed
            # _window.scrollTop nextOffTop
            $("html,body").animate({
                scrollTop: nextOffTop
                }, aniSpeed
            )




    exports.init = ( _this ) ->
        makeItHappen _this




    exports


