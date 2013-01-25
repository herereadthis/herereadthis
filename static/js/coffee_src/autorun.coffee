do autorun = ->

	# console.log "not mobile!"

	init = () ->
		console.log "init autorun"

	

	# Person = Backbone.Model.extend
 #        defaults:
 #            name: 'Fetus',
 #            age: 0
 #        initialize: () ->
 #            console.log "Welcome to this world"
 #            this.on "change:name", (model) ->
 #                name = model.get("name")
 #                console.log "Changed my name to #{name}"
    
 #    person = new Person
 #    	name: "Thomas"
 #    	age: 67
 #    person.set
 #    	name: 'Stewie Griffin'


	# hides address bar on iphones
	# $("html,body").scrollTop 0
	# if window.devicePixelRatio >= 2
 #        window.addEventListener "load",() ->
 #            hideAddressBar = -> window.scrollTo 0, 1
 #            setTimeout hideAddressBar, 0
    # # older version
	# window.addEventListener "load", ()->
	# 	setTimeout ()->
	# 		window.scrollTo(0,1)
	# 	,0