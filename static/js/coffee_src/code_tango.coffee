do ( jQuery ) ->
    $ = jQuery
    settings =
        variableName : true
        # once code has been formatted, add this class
        formatClassName: "code_tango"
        preParent: "blockquote"

    methods = 
        init: ( options ) ->
            this.each () ->
                $.extend(settings, options)
                $this = $ @
                # structure of code is as follows:
                # <blockquote><div><pre><code>var foo = function() {}</code></pre></div></blockquote>
                # formatted structure becomes
                # <blockquote><div>
                # <div><pre><span>1.</span></pre</div>
                # <div><pre><code>var foo = function() {}</code></pre></div>
                # </div></blockquote>
                # an extra layer of wrapping because webkit-based browsers cannot add styling to <PRE>
                $this.closest(settings.preParent).addClass settings.formatClassName
                $this.wrap '<div class="code_container" />'
                $this.wrap '<div class="code_copy" />'
                _code = $this.find "code"
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

                methods.makeIndex $this, lineCount

                # in case the code is wider than the container can hold, a <DIV> will handle the issue
                _div = $this.parent("div")
                divDim =
                    pr: parseInt _div.attr("padding-right"), 10
                    pl: parseInt _div.attr("padding-left"), 10
                    outerWt: _div.outerWidth()
                indexWidth = $this.parent().prev("div").outerWidth()
                _div.parent("div").css
                    "min-width": divDim.outerWt + indexWidth
                # <DIV> width is wide enough so both the code and the indices can float side-by-side
                blockWidth = $this.closest("blockquote").width()
                # console.log divDim.outerWt, indexWidth, divDim.outerWt + indexWidth, blockWidth, blockWidth - indexWidth
                if blockWidth > divDim.outerWt + indexWidth
                    # buggy, fix later
                    # $this.parent("div").css
                    #     "width": blockWidth - indexWidth - divDim.pr - divDim.pl
                else
                    $this.parent("div").parent("div").css
                        "width": divDim.outerWt + indexWidth

                # $this.closest("figure").append $("<p />").html(divDim.outerWt)
                # $this.closest("figure").append $("<p />").html(indexWidth)
                # $this.closest("figure").append $("<p />").html(divDim.outerWt + indexWidth)
                # $this.closest("figure").append $("<p />").html($this.closest("figure").find(".code_container").width())



        makeIndex: ( _this, lineCount ) ->
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





    $.fn.codeTango = ( method ) ->
        if methods[method]
            methods[method].apply( this, Array.prototype.slice.call( arguments, 1 ) )
        else if typeof method is 'object' or not method
            methods.init.apply this, arguments
        else
            $.error 'Method ' + method + ' does not exist on jQuery.codeTango'