###
The accordian player will turn the first child of the given element into a toggle.
All siblings will hide and show based on user clicking on first child
###

do ( jQuery ) ->
    $ = jQuery
    settings =
        toggleAttr: "data-accordian"

    methods = 
        init: ( options ) ->
            this.each () ->
                $.extend(settings, options)
                $this = $ @
                # console.log "accordianPlayer init"

                # exclusion if data attribute in html is set to false
                hitAccordian = if $this.attr(settings.toggleAttr) is "false" then false else true

                if hitAccordian is true
                    methods.makeAccordian $this

                _toggler = $this.find ">:first-child"
                $this.on "click", ">:first-child", () ->
                    console.log "foo"
                    _parent = $(@).parent()
                    if _parent.hasClass "selected"
                        _parent.removeClass "selected"
                        _toggler.siblings().hide()
                        _toggler.find("p").hide()
                    else
                        _parent.addClass "selected"
                        _toggler.siblings().show()
                        _toggler.find("p").show()



        makeAccordian: ( _this ) ->
            _toggler = _this.find ">:first-child"
            console.log _toggler.html()
            _this.addClass "accordian"
            _toggler.siblings().hide()
            _toggler.find("p").hide()
            _toggler.append $("<span />").addClass("toggler")


    $.fn.accordianPlayer = ( method ) ->
        if methods[method]
            methods[method].apply( this, Array.prototype.slice.call( arguments, 1 ) )
        else if typeof method is 'object' or not method
            methods.init.apply this, arguments
        else
            $.error 'Method ' + method + ' does not exist on jQuery.accordianPlayer'