# define ["jquery"], ( $ ) ->
define (require) ->
    $ = require "jquery"
    Modernizr = require "Modernizr"
    exports = {}
    # name of actual file here
    moduleName = "take_me"
    _window = $(window)
    em = parseInt $("body").css("font-size"), 10
    gVars = 
        startEle: {}
        endEle: {}
        navHt: 0
    

    positionMe = ( $this ) ->
        windowHt = _window.height()
        scroll = _window.scrollTop()
        startOffset = gVars.startEle.offset()
        startOff = startOffset.top
        console.log startOff, scroll

        if scroll <= startOff
            thisTop = startOff + windowHt - gVars.navHt
        else
            thisTop = startOff + windowHt - gVars.navHt

        $this.css
            "top": thisTop


    makeItHappen = ( _this ) ->
        # resize header to fit page, accordingly
        # ResizeFu.init _this
        console.log "made it happen for #{ moduleName }"
        gVars.startEle = _this.next()
        gVars.endEle = _this.siblings().last()
        gVars.navHt = _this.height()

        positionMe _this

        _window.scroll () ->
            positionMe _this

        _window.resize () ->
            positionMe _this




    exports.init = ( _this ) ->
        # _this is a jQuery object
        if _this != undefined
            makeItHappen _this
        else
            element = $("body").find("[data-module=\"#{ moduleName }\"]")
            element.each () ->
                makeItHappen $(@)

    exports


