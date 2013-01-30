# define ["jquery"], ( $ ) ->
define (require) ->
    $ = require "jquery"
    Modernizr = require "Modernizr"
    ResizeFu = require "resize_fu"
    exports = {}
    gVars = {}
    # name of actual file here
    moduleName = "coding"
    _window = $(window)

    # global object
    cVars = 
        # once code has been formatted, add this class
        preClass: "code_tango"
        preParent: "blockquote"
        # ideal size is expressed as EMs, that is the width of content
        idealWidth: 108
        # unless specified by data-coding-bgwidth="###" in html, expressed as a 0 <= decimal < 1
        bgWidth: 192
        # unless specified by data-coding-pc="0.###" in html, expressed as EMs
        pc: 0.2
        # width of each bar, unless specified by data-bar-width="0.###" in html, expressed as EMs
        barWidth: 1
        # pLeftThreshold is the extra padding on right that separates content from background, as EMs
        # or defined as data-pleft-threshold
        pLeftThreshold: 1.5
        # number of horizontal bars, unless specified by data-coding-horbar-size="#"
        horbarSize: 2
        # height proportion of horizontal bars, unless specified by data-coding-horfactor="#"
        horFactor: 2
        # padding is left and right, as breathing room past idealSize, expressed as EMs
        sidePad: 5
        rileyColors: [
            "0e90d2","c96977","3f8be6","cea635","0b90d7","cb6573","0b91d6","cb6676","23293d","d0a62e"
            "0e8fd6","cb6371","408ae9","c96474","dfe7f4","0d90d7","ca6774","3a8be6","cfa632","0b91d7"
            "cea834","198fc8","142c47","d2a631","3e8de7","e5ecf7","cc6874","0c95d7","cf6671","172945"
            "3b8ce6","d2a831","0c8fd7","ca6571","0b8eda","e2eefb","398ce9","1092d5","cc6670","0d94db"
            "d5a730","3d8deb","152942","0d91d9","cc6571","428aeb","d4a834","3f8de9","ecf0f7","d3a933"
            "3e8dec","d5a932","3e8cec","d06674","1a2844","3e8cee","d4ab34","3c8fee","0b95dc","d7aa33"
            "0b94dc","f0f1f6","d6aa35","3e8feb","d16772","0c91dc","1a283b","d8ab31","0a97dc","d7ab32"
            "f3f3f6","d36770","3c8feb","202b3d","d1ad3c","4590ea","d7ab32","d36974","0c94d3","d8aa34"
            "0d94db","f1f4f3","d7ad31","0d98dc","d7ad34","4692ec","d56875","242e3e","d6ae33","0a9ce0"
            "d7af34","4a94f0","d26d78","4894ef","0a98dc","eef5f7","0b98dc","daae35","3c96ea","0b98dd"
            "d16e7c","4294ec","1d2d4a","d56c7c","4495ee","dbb03d","4796ea","0e99e3","309bf0"
        ]
        em: parseInt $("body").css("font-size"), 10
        # in pixels, at what point to stop the title fu dancing
        titleThreshold: 1040




    rileyGo = ( _this, lVars) ->
        # create object parameters from passed variables.
        rVars = 
            cWidth: lVars.bgWidth * cVars.em
            cHeight: 100
            pc: lVars.pc
            ideal: lVars.idealWidth * cVars.em
            start: 0
            increment: lVars.barWidth * cVars.em
            pLeft: parseInt(_this.find("section").css("padding-left"),10)
            pLeftThreshold: lVars.pLeftThreshold * cVars.em
            horbarSize: lVars.horbarSize
            horFactor: lVars.horFactor

        rVars.start = rVars.ideal - (rVars.ideal * rVars.pc) + ((rVars.cWidth - rVars.ideal) / 2)
        rVars.docIdealWidth = rVars.ideal + 2 * lVars.sidePad * cVars.em
        rVars.adjustedWidth = rVars.ideal - rVars.pc * rVars.ideal - rVars.pLeftThreshold


        canvas = document.createElement "canvas"
        canvas.width = rVars.cWidth
        canvas.height = rVars.cHeight
        context = canvas.getContext "2d"
        barStart = rVars.start
        for i in cVars.rileyColors
            color = "##{ i }"
            context.fillStyle = color
            context.fillRect barStart,0,rVars.increment,rVars.cHeight
            barStart += rVars.increment


        horBars = cVars.rileyColors.slice 0,rVars.horbarSize

        canvas2 = document.createElement "canvas"
        canvas2.width = rVars.cWidth
        canvas2.height = horBars.length * rVars.increment * rVars.horFactor
        context2 = canvas2.getContext "2d"
        horBarStartWidth = rVars.start
        horBarVert = rVars.increment * (horBars.length - 1) * rVars.horFactor
        for i in horBars
            color = "##{ i }"
            context2.fillStyle = color
            context2.fillRect 0,horBarVert,horBarStartWidth,rVars.increment * rVars.horFactor
            horBarVert -= (rVars.increment * rVars.horFactor)
            horBarStartWidth += rVars.increment


        canvas3 = document.createElement "canvas"
        canvas3.width = rVars.cWidth
        canvas3.height = horBars.length * rVars.increment * rVars.horFactor
        context3 = canvas3.getContext "2d"
        horBarStartWidth = rVars.start
        horBarVert = 0
        for i in horBars
            color = "##{ i }"
            context3.fillStyle = color
            context3.fillRect 0,horBarVert,horBarStartWidth,rVars.increment * rVars.horFactor
            horBarVert += rVars.increment * rVars.horFactor
            horBarStartWidth += rVars.increment


        bgi1 = "url(#{ canvas2.toDataURL("image/png") })"
        bgi2 = "url(#{ canvas3.toDataURL("image/png") })"
        bgi3 = "url(#{ canvas.toDataURL("image/png") })"
        bgs1 = "#{ canvas.width }px #{ canvas2.height }px"
        bgs2 = "#{ canvas.width }px #{ canvas3.height }px"
        bgs3 = "#{ canvas.width }px 100px"

        _this.css
            "background-image": "#{ bgi1 },#{ bgi2 },#{ bgi3 }"
            "background-size": "#{ bgs1 },#{ bgs2 },#{ bgs3 }"
            "background-position": "50% 0%, 50% 100%, 50% 50%"
            "background-repeat": "no-repeat, no-repeat,repeat"


        _title = _this.find "h2"
        if _window.width() >= rVars.docIdealWidth
            # width of the title box
            titleWidth = rVars.pc * rVars.ideal + rVars.pLeft
            _this.children().css
                "padding-right": titleWidth + rVars.pLeftThreshold
                "width": rVars.adjustedWidth
        else
            widthPlusPad = _window.width()
            beyondView = (rVars.cWidth - widthPlusPad) / 2
            titleWidth = (rVars.cWidth - rVars.start) - beyondView
            pRight = titleWidth + rVars.pLeftThreshold
            _this.children().css
                "padding-right": pRight
                "padding-left": ""
                "width": "auto"

        if Modernizr.touch is true
            _this.children().css
                "width": "auto"
        else
            if _window.width() > cVars.titleThreshold
                _title.css
                    "width": titleWidth
                    "height": titleWidth
                    "line-height": "#{ titleWidth }px"
            else
                _title.css
                    "width": ""
                    "height": ""
                    "line-height": ""





    scrollTitle = ( _this ) ->
        if _window.width() > cVars.titleThreshold 
            offset = _this.offset()
            # place is > 0 if any bit of the article is visible in browser.
            place = Math.round _this.outerHeight() + offset.top - _window.scrollTop()
            # if any part of the article is within view
            if _window.scrollTop() + _window.outerHeight() >= offset.top and place > 0
                # showing is amount of pixels of the article is visible from the bottom
                showing = _window.scrollTop() +  _window.height() - offset.top
                # showing / _this.outerHeight()  is percentage that the top of the article is from the bottom
                # 0% if top of article is at the bottom, 100% if top of article is at the top
                # if showing / _this.outerHeight() <= 1
                _title = _this.find "h2"
                titleHeight = _title.height()
                # console.log showing
                topPad = parseFloat(_this.css("padding-top"), 10)
                # if the visible portion of the article is smaller than than the title box
                if showing <= titleHeight
                    _title.css
                        "top": -1 * topPad
                else if place - titleHeight >= 0
                    # range is the distance the title will have to travel.
                    # since there is no travelling until the title is properly in view, minus title height
                    range = _this.outerHeight() - titleHeight
                    # distance scrolling will have to travel to traverse gap 
                    distance = _window.height() + _this.outerHeight() - 2 * titleHeight
                    # theory is percentage until scroll reaches last allowable space to fit title
                    theory = ((showing - titleHeight) / distance)
                    _title.css
                        "top": range * theory - topPad
                # else, user has started scrolling past this article, place the title at the bottom
                else
                    _title.css
                        "top": _this.outerHeight() - titleHeight - topPad


    makeIndex = ( _this, lineCount ) -> 
        # build array of indices based on line count
        indices = []
        indices.length = lineCount
        for i, j in indices
            indices[j] = "#{ j + 1 }."
        # size of largest array element, e.g., "23." = 3
        maxIndex = indices[lineCount - 1].length
        # we are trying to right-align cheat the index number. obviously, "1." will not align with "100."
        for i, j in indices
            # size of array element
            iLength = i.length
            while iLength < maxIndex
                # keep adding spaces until the element is as large as maxIndex
                indices[j] = " #{ i }"
                iLength++
        # finally, wrap them in span tags and add the Index <PRE>
        # _this.closest("div").before($("<div />")).html($("<pre />"))
        _this.closest("div").before $("<div />").addClass("code_copy").html($("<pre />"))
        for i, j in indices
            indices[j] = "<span>#{ i }</span>"
            _this.closest("div").prev().find("pre").append indices[j]
            if j < lineCount
                _this.closest("div").prev().find("pre").append "\n"
            # _this.prev("pre").wrap("<div />")


    code_tango = ( _this ) ->
        # structure of code is as follows:
        # <blockquote><div><pre><code>var foo = function() {}</code></pre></div></blockquote>
        # formatted structure becomes
        # <blockquote><div>
        # <div><pre><span>1.</span></pre</div>
        # <div><pre><code>var foo = function() {}</code></pre></div>
        # </div></blockquote>
        # an extra layer of wrapping because webkit-based browsers cannot add styling to <PRE>
        _this.closest(cVars.preParent).addClass cVars.preClass
        _this.wrap '<div class="code_container" />'
        _this.wrap '<div class="code_copy" />'
        _code = _this.find "code"
        # build an array from each line of code
        snippet = _code.html().split "\n"
        # flush the code to rebuild
        _code.empty()
        # line count becomes more useful when building index column
        lineCount = snippet.length
        for i,j in snippet
            # each array item now wrapped in span tags
            snippet[j] = "<span>#{ i }</span>"
            # append modified array item to code
            _code.append snippet[j]
            # if it's not the last item, add a line break
            if j < lineCount
                _code.append "\n"

        makeIndex _this, lineCount

        # in case the code is wider than the container can hold, a <DIV> will handle the issue
        _div = _this.parent("div")
        divDim =
            pr: parseInt _div.attr("padding-right"), 10
            pl: parseInt _div.attr("padding-left"), 10
            outerWt: _div.outerWidth()
        indexWidth = _this.parent().prev("div").outerWidth()
        _div.parent("div").css
            "min-width": divDim.outerWt + indexWidth
        # <DIV> width is wide enough so both the code and the indices can float side-by-side
        blockWidth = _this.closest("blockquote").width()
        # console.log divDim.outerWt, indexWidth, divDim.outerWt + indexWidth, blockWidth, blockWidth - indexWidth
        if blockWidth > divDim.outerWt + indexWidth
            # buggy, fix later
            # $this.parent("div").css
            #     "width": blockWidth - indexWidth - divDim.pr - divDim.pl
        else
            _this.parent("div").parent("div").css
                "width": divDim.outerWt + indexWidth

        # $this.closest("figure").append $("<p />").html(divDim.outerWt)
        # $this.closest("figure").append $("<p />").html(indexWidth)
        # $this.closest("figure").append $("<p />").html(divDim.outerWt + indexWidth)
        # $this.closest("figure").append $("<p />").html($this.closest("figure").find(".code_container").width())



    makeItHappen = ( _this ) ->
        # resize header to fit page, accordingly
        pres = _this.find "pre"
        for i in pres
            code_tango $(i)


        # set a few globals based on data-attributes
        _body = $("body")
        thisData = {}
        if _this.data("coding-bgwidth") != undefined
            thisData.bgWidth = parseInt _this.data("coding-bgwidth"), 10
        if _this.data("coding-pc") != undefined
            thisData.pc = parseInt((_this.data("coding-pc") * 100), 10) / 100
        if _this.data("coding-bar-width") != undefined
            thisData.barWidth = parseInt((_this.data("coding-bar-width") * 100), 10) / 100
        if _this.data("coding-pleft-threshold") != undefined
            thisData.pLeftThreshold = parseInt((_this.data("coding-pleft-threshold") * 100), 10) / 100
        if _this.data("coding-horbar-size") != undefined
            thisData.horbarSize = parseInt _this.data("coding-horbar-size"), 10
        if _this.data("coding-horfactor") != undefined
            thisData.horFactor = parseInt((_this.data("coding-horfactor") * 100), 10) / 100
        if _body.data("resizefu-ideal-width") !=undefined
            thisData.idealWidth = parseInt _body.data("resizefu-ideal-width"), 10
        if _body.data("resizefu-side-pad") !=undefined
            thisData.sidePad = parseInt _body.data("resizefu-side-pad"), 10


        lVars = {}
        lVars.pc = if thisData.pc? then thisData.pc else cVars.pc
        lVars.bgWidth = if thisData.bgWidth? then thisData.bgWidth else cVars.bgWidth
        lVars.barWidth = if thisData.barWidth? then thisData.barWidth else cVars.barWidth
        lVars.pLeftThreshold = if thisData.pLeftThreshold? then thisData.pLeftThreshold else cVars.pLeftThreshold
        lVars.horbarSize = if thisData.horbarSize? then thisData.horbarSize else cVars.horbarSize
        lVars.horFactor = if thisData.horFactor? then thisData.horFactor else cVars.horFactor
        lVars.idealWidth = if thisData.idealWidth? then thisData.idealWidth else cVars.bgWidth
        lVars.sidePad = if thisData.sidePad? then thisData.sidePad else cVars.sidePad


        rileyGo _this, lVars
        if Modernizr.touch is false
            ResizeFu.init _this
            scrollTitle _this

        _window.resize () ->
            rileyGo _this, lVars

        _window.scroll () ->
            if Modernizr.touch is false
                scrollTitle _this


    exports.init = ( _this ) ->
        # _this is a jQuery object
        if _this != undefined
            makeItHappen _this
        else
            element = $("body").find("[data-module=\"#{ moduleName }\"]")

            element.each () ->
                makeItHappen $(@)

    exports


