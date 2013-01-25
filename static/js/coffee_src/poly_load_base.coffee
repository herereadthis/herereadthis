do polyLoad = ->

	# asyncScripts =
		# these polyfillTests check to see if stuff is working. Check console logs
		# polyfillYep: '/static/stacks/js/polyfill_yep.js'
		# polyfillNope: '/static/stacks/js/polyfill_nope.js'

	# syncScripts = 
		# these polyfillTests check to see if stuff is working. Check console logs
		# polyfillYep: '/static/stacks/js/polyfill_yep.js'
		# polyfillNope: '/static/stacks/js/polyfill_nope.js'

	# not running asyncScripts because we don't need any for now
	# for key, value of asyncScripts
	# 	$.ajax
	# 		url: value
	# 		dataType: "script"
	# 		async: true
	# 		success: (data) ->
				#callbacks

	# example to load scripts. 
	# for key, value of syncScripts
	# 	$.ajax
	# 		url: value
	# 		dataType: "script"
	# 		async: false
	# 		success: (data) ->
	# 			$(document).ready () ->
	# 				_this = $("body")
	# 				if key is "polyfillYep"
	#					console.log "this is polyfillYep"
						

	# MutationObserver = window.MutationObserver or window.WebKitMutationObserver or window.MozMutationObserver	

	Modernizr.load [
		{
			# Test for Media queries
			# which is more or less, a test for IE8
			test : Modernizr.mq('only all'),
			yep : [
			]
			nope : [
			]
			# complete : () ->
				# $ () ->
					# _this = $("body")
					#_this.nameofPlugin()
		},
		{
			# Test for DOM4 Mutation Observers
			# Posed the question to Stack Overflow, and I just answered it myself eventually.
			# http://stackoverflow.com/questions/13297380/
			test : MutationObserver = window.MutationObserver or window.WebKitMutationObserver or window.MozMutationObserver
			yep : [
			]
			nope : [
			]
		},
		{
			# Test for Mobile Devices
			# we add the only all option to add an autorun indepedent of ie8 testing
			test : Modernizr.touch,
			yep : [
				# '/static/js/autorun_mobile.js'
				'/static/css/iphone.css'
				# '/static/js/accordian_player.js'
			]
			nope : [
				'/static/css/query.css'
			]
			# complete : () ->
			# 	_article = $("html.touch").find("article")
			# 	if _article.html() != undefined
			# 		_article.accordianPlayer()
		}
		# {
		# 	# these files must be loaded regardless
		# 	load: [ 
		# 		'/static/js/maya_stripes.js'
		# 	]
		# 	complete : () ->
		# }
	]

