# define ["jquery"], ( $ ) ->
define (require) ->
    $ = require "jquery"
    Modernizr = require "Modernizr"
    NextArrow = require "next_arrow"
    ResizeFu = require "resize_fu"
    NextArrow = require "next_arrow"
    # NextArrow = require "next_arrow"
    exports = {}
    gVars =
        # rate is based on distance traveled: set how many pixels traveled per millisecond
        scrollSpeed: 0.4
        # pretty complicated, but basically log rate of scrolling. Set >= 1
        # If the distance is further, scrolling is a little faster.
        logFactor: 1.8
    # name of actual file here
    moduleName = "head_more"
    em = parseInt $("body").css("font-size"), 10
    _window = $(window)


    # adds a little more intuitive action for user: the link acts for the whole list item
    # E.G. <li>lorem ipsum <a href="/foo">sit dolar</a> amet</li>,
    # if user clicks on lorem ipsum, is redirected to "/foo"
    makeNavClick = ( _this ) ->
        _this.on "click","li", (e) ->
            do e.preventDefault
            _links = $(@).find "a"
            # only works if there is only one link in the list item
            if _links.length is 1
                href = _links.attr "href"
                getID = href.split "/"
                window.location.href = href
                if getID[1] != ""
                    id = "##{ getID[1] }"
                    articleOffset = $(id).offset()
                    artOffTop = articleOffset.top
                    if $(id).data("nudge-top")?
                        artOffTop += parseInt $(id).data("nudge-top")
                    # that is, the further away the next article is, the longer it will take to scroll there
                    distance = artOffTop - _window.scrollTop()
                    voodoo = Math.log gVars.logFactor * ($(document).height() / distance)
                    voodoo = 1 if voodoo < 1
                    aniSpeed = Math.round distance * voodoo / (1 / gVars.scrollSpeed)
                    # console.log voodoo, aniSpeed, artOffTop, aniSpeed/artOffTop
                    $("html,body").animate({
                        scrollTop: artOffTop
                        }, aniSpeed
                    )


    makeItHappen = ( _this ) ->
        # resize header to fit page, accordingly
        ResizeFu.init _this
        makeNavClick _this.find("nav")
            

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


