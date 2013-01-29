# http://paceyourself.net/js/util/analytics.js
define (require) ->
	# $ = require "jquery"
	exports = 
		track: ( accountId ) ->
			_gaq = window._gaq = _gaq or []
			ga = document.createElement "script"
			s = document.getElementsByTagName('script')[0]

			_gaq.push ['_setAccount', accountId]
			_gaq.push ['_trackPageview']
			
			ga.type = "text/javascript"
			ga.async = true

			# secure = "https://ssl.google-analytics.com/ga.js"
			# unsecure = "http://www.google-analytics.com/ga.js"
			ga.src = (if 'https:' is document.location.protocol then 'https://ssl' else 'http://www') + ".google-analytics.com/ga.js"
			console.log _gaq, "!"

			s.parentNode.insertBefore ga, s
			# window.onload = () ->
			# 	s.parentNode.insertBefore ga, s
			# 	# $("head").append $("<script />").attr
			# 	# 	"type": "text/javascript"
			# 	# 	"async": true
			# 	# 	"src": if 'https:' is document.location.protocol then secure else unsecure
			# 	console.log "analytics init"

	exports
