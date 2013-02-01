# define ["jquery"], ( $ ) ->
define (require) ->
    $ = require "jquery"
    Modernizr = require "Modernizr"
    ResizeFu = require "resize_fu"
    exports = {}
    # name of actual file here
    moduleName = "excerpts"
    _window = $(window)
    gVars = 
        # short expand-contract
        ec:
            showLength: 110
            tail: 30
            cutClassName: "cut_after"
            cutClass: ""
            hellipClassName: "cut_hellip"
            hellipClass: ""
            hellip: " [&hellip;] "
            textShowClassName: "cut_show"
            textShowClass: ""
            moreText: "Show full excerpt &raquo;"
            lessText: "&laquo; Hide text"
            container: "blockquote"
    



    expandContract = ( _this, lVars ) ->
        # remember, the initial state before manipulation is aria-expanded="true" because nothing has been done yet.
        # "copy" - buld an array of this section's paragraphs as objects
        copy = _this.find("p")
        # textArray is an array of the word counts of each paragraph of this section
        textArray = []
        for i, j in copy
            # count the number of occurances of a character in a string http://stackoverflow.com/questions/881085/
            textArray[j] = ($(i).html().match(/\S+\s*/g)||[]).length
        # total is the total word count of this section
        total = 0
        for k in textArray
            total += k
        # console.log total, textArray

        # tail means that a cut won't be iniated if the the copy after the cut is too small
        _container = _this.closest(lVars.ec.container)
        if total > lVars.ec.showLength + lVars.ec.tail
            wordCount = 0
            # just a counter
            paraSlice = 0
            # calculate the number of paragraphs that appear before the cutoff,
            # and add up the word count of the paragraph
            while wordCount < lVars.ec.showLength
                # if adding the wordcount of the next paragraph will not exceed the cutoff
                if wordCount + textArray[paraSlice] < lVars.ec.showLength
                    wordCount += textArray[paraSlice]
                else
                    break
                paraSlice++
            cutoff = lVars.ec.showLength - wordCount

            # here is the essential logic of this method....
            # UN-COMMENT the console.log below for the explanation:
            # console.log "This section has #{total} words, which is greater than the cutoff of #{lVars.ec.showLength}."
            # console.log "Initiate a cutoff after #{ cutoff } words at paragraph ##{ paraSlice + 1 },"
            # console.log "which itself contains #{ textArray[paraSlice] } words"

            # target the manuplation here
            _target = $(copy[paraSlice])
            targetPara = _target.html()
            # the character to catch on splits, in this case, a space
            delimiter = " "
            # put this paragraph into a array
            tokens = targetPara.split(delimiter)
            # slice 1: everything before cutoff
            str1Array = tokens.slice(0, cutoff - 1)
            str1 = str1Array.join(delimiter)
            # slice 2: everything after cutoff
            str2Array = tokens.slice(cutoff - 1)
            str2 = str2Array.join(delimiter)


            # wipe the copy in the target paragraph, add the first slice that should remain visible, with cut class
            _target.addClass(gVars.ec.cutClassName).html($("<span />").addClass(gVars.ec.cutClassName).html(str1))
            # append the second slice (rest of paragraph), which will become hidden
            _target.append(" ").append $("<span />").html(str2)
            # append the ellipsis copy
            _target.append($("<span />").addClass(gVars.ec.hellipClassName).html(gVars.ec.hellip))
            # add the "read more" link
            _target.append($("<a />").addClass(gVars.ec.textShowClassName).html(gVars.ec.moreText).attr(
                "href":"#"
                ))
            # also, add a "read more" link after the end of the last paragraph
            $(copy[copy.length - 1]).append($("<br />")).append $("<a />").addClass(gVars.ec.textShowClassName).attr(
                "href":"#"
            ).html(gVars.ec.lessText)

            # after all is do            
            _container.attr
                "aria-expanded": false


        else
            _container.attr
                "aria-expanded": true


        _this.on "click", gVars.ec.textShowClass, (e) ->
            do e.preventDefault
            ariaState = _this.attr("aria-expanded")
            if  _this.attr("aria-expanded") is "false"
                 _this.attr "aria-expanded", true
            else
                 _this.attr "aria-expanded", false




    makeItHappen = ( _this ) ->
        # resize header to fit page, accordingly
        # ResizeFu.init _this
        # console.log "made it happen for #{ moduleName }"

        gVars.ec.cutClass = ".#{ gVars.ec.cutClassName }"
        gVars.ec.hellipClass = ".#{ gVars.ec.hellipClassName }"
        gVars.ec.textShowClass = ".#{ gVars.ec.textShowClassName }"

        thisData = {}
        if _this.data("excerpts-ec-show-length") != undefined
            thisData.ecShowLength = parseInt _this.data("excerpts-ec-show-length"), 10
        if _this.data("excerpts-ec-tail") != undefined
            thisData.ecTail = parseInt _this.data("excerpts-ec-tail"), 10
        if _this.data("excerpts-ec-more-text") != undefined
            thisData.ecMoreText = _this.data("excerpts-ec-more-text")
        if _this.data("excerpts-ec-less-text") != undefined
            thisData.ecLessText = _this.data "excerpts-ec-less-text"
        if _this.data("excerpts-ec-container") != undefined
            thisData.ecContainer = _this.data "excerpts-ec-container"


        lVars = {}
        lVars.ec = {}
        lVars.ec.showLength = if thisData.ecShowLength? then thisData.ecShowLength else gVars.ec.showLength
        lVars.ec.tail = if thisData.ecTail? then thisData.ecTail else gVars.ec.tail
        lVars.ec.moreText = if thisData.ecMoreText? then thisData.ecMoreText else gVars.ec.moreText
        lVars.ec.lessText = if thisData.ecLessText? then thisData.ecLessText else gVars.ec.lessText
        lVars.ec.container = if thisData.ecContainer? then thisData.ecContainer else gVars.ec.container


        _container = _this.find lVars.ec.container
        for i in _container
            expandContract $(i), lVars

        if Modernizr.touch is false
            ResizeFu.init _this




    exports.init = ( _this ) ->
        # _this is a jQuery object
        if _this != undefined
            makeItHappen _this
        else
            element = $("body").find("[data-module=\"#{ moduleName }\"]")
            element.each () ->
                makeItHappen $(@)

    exports


