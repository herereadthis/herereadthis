do ( jQuery ) ->
    $ = jQuery

    settings =
        variableName: true
        message: "hello world!"
        # maya stripes spans two sectioning elements
        complement: {}
        # whether to have a top clearance on stripes
        clearance: false
        # height of bars
        barHt: 1000
        # express as ems
        pageWidth: 108
        # expresse as EMs, the right padding of text from maya stripes
        padThreshold: 2
        # class for maya stripes
        maya: "maya_stripes"

    gVars = 
        phi: 1.618
        barDim: []
        em: 0
        maya: ""

    methods = 
        init: ( options ) ->
            this.each () ->
                $.extend(settings, options)
                $this = $ @
                # add the maya class to this
                $this.addClass settings.maya
                # set phi, the golden ratio
                # http://en.wikipedia.org/wiki/Golden_ratio
                gVars.phi = (1 + Math.sqrt(5))/2 - 1
                # console.log "mayaStripes init, #{ gVars.phi }"
                # set page EM value
                gVars.em = parseInt $("html").css("font-size"),10
                # set class for maya stripes
                gVars.maya = ".#{ settings.maya }"

                # set the bar dimensions
                roundedDim = methods.makeBarDim $this
                # set css for maya stripes
                methods.makeMayaCSS $this, roundedDim



                # resize when screen is smaller maya stripes
                methods.makeMayaPad $this, roundedDim
                $(window).resize () ->
                    methods.makeMayaPad $this, roundedDim



        # get minimum value of array
        arraySortMin: ( array ) ->
            min = Math.min.apply Math, array
            min

        getPad: ( _this ) ->
            _thisPad = 
                top: parseInt(_this.css("padding-top"), 10) / gVars.em
                right: parseInt(_this.css("padding-right"), 10) / gVars.em
                bottom: parseInt(_this.css("padding-bottom"), 10) / gVars.em
                left: parseInt(_this.css("padding-left"), 10) / gVars.em
            _thisPad


        makeMayaPad: ( _this, roundedDim ) ->
            # window width
            docWidth = $(window).width() / gVars.em
            # console.log docWidth


            # find left-most positioning of maya stripe
            stripePos = []
            for i in roundedDim
                stripePos.push i[1]
            minVal = methods.arraySortMin stripePos
            
            # right most position is express as EMs
            rightEdge = minVal / gVars.em

            rightPadRaw = settings.pageWidth - rightEdge
            # round off right padding to 2 decimal places
            rightPadRound = Math.round(rightPadRaw * 100) / 100
            # when screen resolution is less than the right most maya bar, then no additional padding is needed
            # so set to 0
            rightPadRound = if rightPadRound >= 0 then rightPadRound else 0

            # if window size can contain max size of of element
            _thisPad = methods.getPad _this
            if settings.pageWidth + _thisPad.right + _thisPad.left <= docWidth
                adjustedPad = _this.outerWidth(false) / gVars.em - rightEdge - _thisPad.left + settings.padThreshold
                adjustedPad = (Math.round(adjustedPad * 100) / 100) * gVars.em 
            # if window size cannot contain max width
            else if docWidth > rightEdge
                adjustedPad = (docWidth - _thisPad.left - rightEdge) * gVars.em
            # # if window size leaves maya out of view
            else
                adjustedPad = _thisPad.left * gVars.em
            # adjustedPad -= 1 / gVars.em

            _this.children().css
                "padding-right": adjustedPad
            #     # "margin-right": 1
            #     "background-color": "transparent"


        makeBarDim: ( _this ) ->
            # set width of design, which is phi remainder of phi remainder of max page width
            mayaWidth = (settings.pageWidth * gVars.em) * (1 - gVars.phi) * (1 - gVars.phi)
            # sum of width of all 3 stripes is phi of width
            mayaPhiWidth = gVars.phi * mayaWidth
            # first bar is phi of phi of design width
            bar1Width = gVars.phi * mayaPhiWidth
            # remainder is difference
            mayaRemainder = mayaPhiWidth - bar1Width
            # second bar is phi of remainder
            bar2Width = gVars.phi * mayaRemainder
            # third bar is what's left
            bar3Width = mayaRemainder - bar2Width


            # background positioning is offset by left padding of element, if exists
            leftPad = parseInt _this.css("padding-left"), 10
            # set a baseline offset for all the maya stripes
            baselineOffset = settings.pageWidth * gVars.em + leftPad

            # generate array for bar dimensions
            gVars.barDim = [
                [bar1Width, baselineOffset - mayaWidth]
                [bar2Width, baselineOffset - mayaWidth + mayaPhiWidth]
                [bar3Width, baselineOffset - bar3Width]
            ]
            # create array of rounded values
            roundedDim = []
            # loop through bar dimensions to rounded dimensions
            for row, index in gVars.barDim
                # make each element roundedDim a new array
                roundedDim[index] = []
                for i in row
                    roundedDim[index].push Math.round(i)
            # a little insurance that rounding does not improperly clip last stripe
            lastArr = roundedDim.length - 1
            if roundedDim[lastArr][0] + roundedDim[lastArr][1] - leftPad != settings.pageWidth * gVars.em + 1
                roundedDim[lastArr][1] = settings.pageWidth * gVars.em + leftPad - roundedDim[lastArr][0]
            roundedDim


        makeMayaCSS: ( _this, roundedDim ) ->
            # make set for background size
            bgSize = ""
            # obviously, this overkill and could just as well be done manually, but overkill is fun
            for i, j in roundedDim
                # generate pair of attributes for each background image set
                bgSizePair = "#{ i[0] }px #{ settings.barHt }px"
                # separated by commas if not last
                if j != roundedDim.length - 1
                    bgSizePair += ", "
                # generate background size attribute
                bgSize += bgSizePair
            # make set for background position
            bgPos = ""
            # special positioning for element if clearance is true
            if settings.clearance is true
                mayaPadding = roundedDim[1][0] + roundedDim[2][0]
            else
                mayaPadding = 0
            # similar logic to generation of background size
            for i, j in roundedDim
                bgPosPair = "#{ i[1] }px #{ mayaPadding }px"
                if j != roundedDim.length - 1
                    bgPosPair += ", "
                bgPos += bgPosPair
            _this.css
                "background-size": bgSize
                "background-position": bgPos

            # # special positioning for banner
            # mayaPadding = roundedDim[1][0] + roundedDim[2][0]
            # bannerBgPos = ""
            # # similar logic to generation of background size
            # for i, j in roundedDim
            #     bgPosPair = "#{ i[1] }px #{ mayaPadding }px"
            #     if j != roundedDim.length - 1
            #         bgPosPair += ", "
            #     bannerBgPos += bgPosPair
            # $(settings.banner).css
            #     "background-position": bannerBgPos



    $.fn.mayaStripes = ( method ) ->
        if methods[method]
            methods[method].apply( this, Array.prototype.slice.call( arguments, 1 ) )
        else if typeof method is 'object' or not method
            methods.init.apply this, arguments
        else
            $.error 'Method ' + method + ' does not exist on jQuery.mayaStripes'