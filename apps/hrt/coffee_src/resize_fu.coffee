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
    gVars =
        # these variables will be passed globally inside ResizeFu
        browserWt: 0
        browserHt: 0
        # ideal size is expressed as EMs, that is the width of content
        idealWidth: 108
        # padding is left and right, as breathing room past idealSize, expressed as EMs
        sidePad: 5
        # EM-value of page
        em: parseInt $("body").css("font-size"), 10
        # The rest of the globals will be passed locally
        # maximum height displacement, that is ratio of height to ((idealsize / em) + 2 * sizePad), is PHI
        maxRatio: (1 + Math.sqrt(5)) / 2 - 1
        # margins between articles, in case content is larger than browser can fit, expressed as EMs
        thresholdTop: 5
        thresholdBot: 5
        # to remind user that more content is to come, offer a small slice of the next article down, EMs
        peekNext: 3


    getBrowserDim = () ->
        gVars.browserWt = do $(window).width
        gVars.browserHt = do $(window).height


    getElementDim = ( _this ) ->
        _this.css
            # "min-height":""
            "padding-top":""
            "padding-bottom":""
        thisDim = 
            width: do _this.width
            height: do _this.height
            outerWt: _this.outerWidth true
            outerHt: _this.outerHeight true
            padding:
                top: parseInt _this.css("padding-top"),10
                right: parseInt _this.css("padding-right"),10
                bottom: parseInt _this.css("padding-bottom"),10
                left: parseInt _this.css("padding-left"),10
        
        thisDim



    makePads = ( _this, threshTop, threshBot ) ->
        threshTop = threshTop or 0
        threshBot = threshBot or threshTop
        _this.css
            "padding-top": "#{ threshTop }em"
            "padding-bottom": "#{ threshBot }em"


    makeResize = ( _this, thisData, lVars ) ->
        # get the browser's dimensions
        do getBrowserDim
        # get the box dimensions of the article
        thisDim = getElementDim _this

        # calculate theoretical ideal width
        theoryWidth = (gVars.idealWidth + 2 * gVars.sidePad) * gVars.em
        # that is, if browser width can allow for ideal width
        if gVars.browserWt > theoryWidth
            # condition 1: if capping article height to browser height will clip content
            if gVars.browserHt < thisDim.height
                console.log "we have too much for  #{_this.find("h2").html()}"
                makePads _this, lVars.thresholdTop, lVars.thresholdBot

            # condition 2: if the height of the browser is too great such that resizing becomes impractical
            else if ((gVars.browserHt - lVars.peekNext * gVars.em) / (theoryWidth)) > lVars.maxRatio
                console.log "we have very large window size for  #{_this.find("h2").html()}"
                # console.log "gVars.browserHt (#{gVars.browserHt}) is too great for #{_this.find("h2").html()}"
                # sub-condition 2A: if adding threshold padding is less than max ratio
                # height if we added the article's height to thresholds
                subTheoryHeight = thisDim.height + (lVars.thresholdTop + lVars.thresholdBot) * gVars.em
                # console.log thisDim.height, (lVars.thresholdTop + lVars.thresholdBot) * gVars.em
                if subTheoryHeight < lVars.maxRatio * theoryWidth
                    # if data attributes specify that article is not to have top and bottom paddings,
                    # then give a min height
                    if thisData.thresholdTop is 0 and thisData.thresholdBot is 0
                        _this.css
                            "min-height": lVars.maxRatio * theoryWidth
                    # else, create threshold paddings to make article same height as ratio definition
                    else 
                        thresholds = (lVars.maxRatio * theoryWidth) - thisDim.height
                        thresholds = (thresholds / 2) / gVars.em
                        makePads _this, thresholds

                # sub-condition 2B: otherwise add thresholds padding
                else
                    makePads _this, lVars.thresholdTop, lVars.thresholdBot

            # condition 3: the ideal one: resize article to fit whole of page, with peek
            else
                console.log "we have ideal for  #{_this.find("h2").html()}"
                # sub-condition 3A: if the added padding to fill out height of article is greater than thresholds
                # console.log thisData, _this.find("h2").html()
                console.log (gVars.browserHt-thisDim.height)/gVars.em, (lVars.thresholdTop+lVars.thresholdBot+lVars.peekNext)
                if ((gVars.browserHt-thisDim.height)/gVars.em) > (lVars.thresholdTop+lVars.thresholdBot+lVars.peekNext)
                    # special case where we don't want any padding means set a min-height
                    if lVars.thresholdTop is 0 and lVars.thresholdBot is 0
                        # console.log "both paddings are set to 0, so set at min height"
                        _this.css
                            "min-height": "#{ (gVars.browserHt / gVars.em) - lVars.peekNext }em"

                    else
                        # then the thresholds will be calculated such that article appears visually at center of page,
                        # minus a little peek for succeeding content
                        # if thisData.thresholdTop is undefined and thisData.thresholdBot is undefined
                        #   threshtop = (((gVars.browserHt - thisDim.height) / gVars.em) - lVars.peekNext) / 2
                        #   threshBot = threshtop
                        # else if thisData.thresholdTop.length and thisData.thresholdBot is undefined
                        thresholds = (((gVars.browserHt - thisDim.height) / gVars.em) - lVars.peekNext)
                        # makePads _this, threshtop, threshBot
                        if thisData.thresholdTop is undefined and thisData.thresholdBot is undefined
                            console.log "both thresholds are undefined"
                            theoryThresholds = thresholds / 2
                            makePads _this, thresholds / 2
                        else if thisData.thresholdTop != undefined and thisData.thresholdBot is undefined
                            botT = if thresholds - thisData.thresholdTop >= 0 then thresholds - thisData.thresholdTop else 0
                            makePads _this, thisData.thresholdTop, botT
                        else if thisData.thresholdTop is undefined and thisData.thresholdBot != undefined
                            topT = if thresholds - thisData.thresholdBot >= 0 then thresholds - thisData.thresholdBot else 0
                            makePads _this, topT, thisData.thresholdBot
                        else
                            makePads _this, thisData.thresholdTop, thisData.thresholdBot


                # sub-condition 3B: if adding thresholds to center the content makes for very tiny thresholds,
                # then default to global variables, unless data-attributes specify otherwise.
                else
                    # console.log "4567890"
                    makePads _this, lVars.thresholdTop, lVars.thresholdBot

        # else, browser width cannot allow for ideal width
        else
            if lVars.thresholdTop is 0 and lVars.thresholdBot is 0
                _this.css
                    "min-height": "#{ (gVars.browserHt / gVars.em) - lVars.peekNext }em"
            else
                makePads _this, lVars.thresholdTop, lVars.thresholdBot

    # in case another module needs to grab peekNext
    exports.getPeekNext = ( _this ) ->
        if _this.data("resizefu-peek-next") != undefined
            tdPeekNext = parseInt _this.data("resizefu-peek-next"), 10
        peekNext = if tdPeekNext? then tdPeekNext else gVars.peekNext
        peekNext


    exports.init = ( _this ) ->
        # console.log "init ResizeFu for #{_this.find("h2").html()}"
        settings = 
            var1: "foo"
        _body = $("body")
        # set a few globals based on data-attributes
        thisData = {}
        if _this.data("resizefu-threshold-top") != undefined
            thisData.thresholdTop = parseInt _this.data("resizefu-threshold-top"), 10
        if _this.data("resizefu-threshold-bottom") != undefined
            thisData.thresholdBot = parseInt _this.data("resizefu-threshold-bottom"), 10
        if _this.data("resizefu-peek-next") != undefined
            thisData.peekNext = parseInt _this.data("resizefu-peek-next"), 10
        if _this.data("resizefu-max-ratio") != undefined
            thisData.maxRatio = parseFloat _this.data("resizefu-max-ratio"), 10
        if _body.data("resizefu-ideal-width") !=undefined
            thisData.idealWidth = parseInt _body.data("resizefu-ideal-width"), 10
        if _body.data("resizefu-side-pad") !=undefined
            thisData.sidePad = parseInt _body.data("resizefu-side-pad"), 10

        lVars = {}



        lVars.thresholdTop = if thisData.thresholdTop? then thisData.thresholdTop else gVars.thresholdTop
        lVars.thresholdBot = if thisData.thresholdBot? then thisData.thresholdBot else gVars.thresholdBot
        lVars.maxRatio = if thisData.maxRatio? then thisData.maxRatio else gVars.maxRatio
        lVars.peekNext = if thisData.peekNext? then thisData.peekNext else gVars.peekNext
        lVars.idealWidth = if thisData.idealWidth? then thisData.idealWidth else gVars.idealWidth
        lVars.sidePad = if thisData.sidePad? then thisData.sidePad else gVars.sidePad


        # console.log _this.data("module"), lVars.peekNext, lVars.thresholdBot, thisData.peekNext

        makeResize _this, thisData, lVars
        $(window).resize () ->
            makeResize _this, thisData, lVars




    exports


