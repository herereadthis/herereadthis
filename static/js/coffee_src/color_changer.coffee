define ["jquery"], ( $ ) ->
	exports = {}
	colors = ['red', 'blue', 'yellow', 'green', 'orange', 'purple']
	getRandomColor = () ->
		max = colors.length
		index = Math.floor(Math.random()*max+1)
		return colors[index]

	exports.init = ( element ) ->
		previousColor = ""
		element.click () ->
			color = ""
			while !color or color is previousColor
				color = getRandomColor()
			element.css "background-color", color
			previousColor = color

	exports


	