do ( jQuery ) ->
    $ = jQuery
    settings =
        variableName : true
        message : "hello world!"

    methods = 
        init: ( options ) ->
            this.each () ->
                $.extend(settings, options)
                $this = $ @
                console.log "widerFatter init"
                methods.spitMessage settings.message

        spitMessage: ( msg ) ->
            console.log "your message is: #{ msg }"


    $.fn.widerFatter = ( method ) ->
        if methods[method]
            methods[method].apply( this, Array.prototype.slice.call( arguments, 1 ) )
        else if typeof method is 'object' or not method
            methods.init.apply this, arguments
        else
            $.error 'Method ' + method + ' does not exist on jQuery.widerFatter'