# define ["jquery"], ( $ ) ->
# Resize fu is going to attempt to size articles on the page to fit the entire height.
# somethings to consider: the browser is too out of whack to size appropriately.
# for example, on cinema displays, sizing articles to fit page will create wayyy to much empty space
# What about if content is much larger than browser can fit?
# We can set min-height but must consider margins between articles
# Page scaling: return values as EM-values
define (require) ->
	$ = require "jquery"
	Modernizr = require "Modernizr"
	exports = {}
	gVars =
		browserWt: 0
		browserHt: 0
		# ideal size is expressed as EMs, that is the width of content
		idealWidth: 108
		# padding is left and right, as breathing room past idealSize, expressed as EMs
		sidePad: 5
		# margins between articles, in case content is larger than browser can fit, expressed as EMs
		threshold:
			top: 5
			bottom: 5
		# maximum height displacement, that is ratio of height to ((idealsize / em) + 2 * sizePad), is PHI
		maxRatio: (1 + Math.sqrt(5)) / 2 - 1
		# to remind user that more content is to come, offer a small slice of the next article down, EMs
		peekNext: 3
		# EM-value of page
		em: parseInt $("body").css("font-size"), 10


	getBrowserDim = () ->
    	gVars.browserWt = do $(window).width
    	gVars.browserHt = do $(window).height


	getElementDim = ( _this ) ->
    	_this.css
    		"padding-top":""
    		"padding-bottom":""
    	thisDim = 
    		width: do _this.width
    		height: do _this.height
    		outerWt: _this.outerWidth true
    		outerHt: _this.outerHeight true
    		padding:
    			top: parseInt _this.css("padding-top"),10
    			right: parseInt _this.css("padding-right"),10
    			bottom: parseInt _this.css("padding-bottom"),10
    			left: parseInt _this.css("padding-left"),10
    	
    	thisDim



    makePads = ( _this, threshTop, threshBot ) ->
    	threshTop = threshTop or 0
    	threshBot = threshBot or threshTop
    	_this.css
    		"padding-top": "#{ threshTop }em"
    		"padding-bottom": "#{ threshBot }em"


    makeResize = ( _this, thisData ) ->
    	# get the browser's dimensions
    	do getBrowserDim
    	# get the box dimensions of the article
    	thisDim = getElementDim _this

    	# calculate theoretical ideal width
    	theoryWidth = (gVars.idealWidth + 2 * gVars.sidePad) * gVars.em
    	# that is, if browser width can allow for ideal width
    	if gVars.browserWt > theoryWidth
	    	# condition 1: if capping article height to browser height will clip content
	    	if gVars.browserHt < thisDim.height
		    	console.log "we have too much for  #{_this.find("h2").html()}"
		    	makePads _this, thisDim.padding.top / gVars.em, gVars.threshold.bottom

	    	# condition 2: if the height of the browser is too great such that resizing becomes impractical
	    	else if ((gVars.browserHt - gVars.peekNext * gVars.em) / (theoryWidth * gVars.em)) > gVars.maxRatio
		    	console.log "we have very large window size for  #{_this.find("h2").html()}"
	    		# console.log "gVars.browserHt (#{gVars.browserHt}) is too great for #{_this.find("h2").html()}"
	    		# sub-condition A: if adding threshold padding is less than max ratio
	    		# height if we added the article's height to thresholds
	    		subTheoryHeight = thisDim.height + (gVars.threshold.top + gVars.threshold.bottom) * gVars.em
	    		if subTheoryHeight < gVars.maxRatio * theoryWidth * gVars.em
	    			thresholds = (gVars.maxRatio * theoryWidth * gVars.em) - (thisDim.height)
	    			thresholds = (thresholds / 2) / gVars.em
	    			makePads _this, thresholds

	    		# sub-condition B: otherwise add thresholds padding
	    		else
	    			makePads _this, gVars.threshold.top, gVars.threshold.bottom

	    	# condition 3: the ideal one: resize article to fit whole of page, with peek
		    else
		    	console.log "we have ideal for  #{_this.find("h2").html()}"
		    	# sub-condition A: if the added padding to fill out height of article is greater than thresholds
		    	# console.log thisData, _this.find("h2").html()
		    	# alert "#{thisData.threshold.top}, #{_this.find("h2").html()}"
		    	# tTop = if thisData.threshold.top.length then thisData.threshold.top else gVars.threshold.top
		    	# tBot = if thisData.threshold.bottom.lenth then thisData.threshold.bottm else gVars.threshold.bottom
		    	if ((gVars.browserHt - thisDim.height) / gVars.em) > (gVars.threshold.top + gVars.threshold.bottom)
		    		# then the thresholds will be calculated such that article appears visually at center of page,
		    		# minus a little peek for succeeding content
		    		# if thisData.threshold.top is undefined and thisData.threshold.bottom is undefined
	    			# 	threshtop = (((gVars.browserHt - thisDim.height) / gVars.em) - gVars.peekNext) / 2
	    			# 	threshBot = threshtop
	    			# else if thisData.threshold.top.length and thisData.threshold.bottom is undefined
	    			thresholds = (((gVars.browserHt - thisDim.height) / gVars.em) - gVars.peekNext) / 2
	    			# makePads _this, threshtop, threshBot
	    			makePads _this, thresholds


	    		# sub-condition B: if adding thresholds to center the content makes for very tiny thresholds,
	    		# then default to global variables, unless data-attributes specify otherwise.
	    		else
	    			makePads _this, gVars.threshold.top, gVars.threshold.bottom
	    
	    # else, browser width cannot allow for ideal width
	    else
	    	makePads _this, gVars.threshold.top, gVars.threshold.bottom



	exports.init = ( _this ) ->
		settings = 
			var1: "foo"
		_body = $("body")
		# set a few globals based on data-attributes
		thisData = 
			idealWidth: if _body.data("resizefu-ideal-width") != undefined then parseInt _body.data("resizefu-ideal-width"), 10
			sidePad: if _body.data("resizefu-side-pad") != undefined then parseInt _body.data("resizefu-side-pad"), 10
			threshold: 
				top: if _this.data("resizefu-threshold-top") != undefined then parseInt _this.data("resizefu-threshold-top"), 10
				bottom: if _this.data("resizefu-threshold-bottom") != undefined then parseInt _this.data("resizefu-threshold-bottom"), 10
			peekNext: if _this.data("resizefu-peek-next") != undefined then parseInt _this.data("resizefu-peek-next"), 10
			maxRatio: if _this.data("resizefu-max-ratio") != undefined then parseInt _this.data("resizefu-max-ratio"), 10
		
		gVars.idealWidth = if thisData.idealWidth? then thisData.idealWidth else gVars.peekNext
		gVars.sidePad = if thisData.sidePad? then thisData.sidePad else gVars.peekNext
		gVars.threshold = 
			top: if thisData.threshold.top? then  thisData.threshold.top else gVars.threshold.top
			bottom: if thisData.threshold.bottom? then  thisData.threshold.bottom else gVars.threshold.top
		gVars.peekNext = if thisData.peekNext? then thisData.peekNext else gVars.peekNext
		gVars.maxRatio = if thisData.maxRatio? then thisData.maxRatio else gVars.maxRatio
		# console.log gVars

		makeResize _this, thisData
		$(window).resize () ->
			makeResize _this




	exports


