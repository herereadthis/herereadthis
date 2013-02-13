# http://paceyourself.net/js/util/analytics.js
define (require) ->
	$ = require "jquery"
	exports = 
		track: ( accountId ) ->
			accountId = $("body").data("google-analytics") or accountId
			
			_gaq = window._gaq = _gaq or []
			ga = document.createElement "script"
			s = document.getElementsByTagName('script')[0]

			_gaq.push ['_setAccount', accountId]
			_gaq.push ['_trackPageview']
			console.log _gaq
			
			ga.type = "text/javascript"
			ga.async = true

			ga.src = (if 'https:' is document.location.protocol then 'https://ssl' else 'http://www') + ".google-analytics.com/ga.js"
			# console.log _gaq, "!"

			s.parentNode.insertBefore ga, s

	exports
