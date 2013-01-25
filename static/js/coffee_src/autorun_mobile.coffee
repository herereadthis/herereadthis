do autorunMobile = ->


	# ugh, revisit with http://stackoverflow.com/questions/9830186/
	window.addEventListener "load", () ->
        hideAddressBar = -> window.scrollTo 0, 0
        setTimeout hideAddressBar, 100

	window.addEventListener "orientationchange", () ->
        hideAddressBar = -> window.scrollTo 0, 0
        setTimeout hideAddressBar, 100