# define ["jquery"], ( $ ) ->
define (require) ->
	$ = require "jquery"
	Modernizr = require "Modernizr"
	ResizeFu = require "resize_fu"
	exports = {}
	gVars = {}
	# name of actual file here
	moduleName = "coding"
	# once code has been formatted, add this class
	preClass = "code_tango"
	preParent = "blockquote"
	em = parseInt $("body").css("font-size"), 10



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
        _this.closest(preParent).addClass preClass
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
		console.log pres.length
		for i in pres
			code_tango $(i)
		# pres.each () ->
			# console.log pres.html()
			# code_tango pres
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


