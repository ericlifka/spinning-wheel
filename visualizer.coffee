PI = Math.PI
TWO_PI = Math.PI * 2
HALF_PI = Math.PI / 2
THREE_HALFS_PI = Math.PI * 3 / 2

class Dot
	constructor: (@radius, @center, rate = 5, container=null, @angle=HALF_PI) ->
		@div = $ '<div class="dot">'
		@setPosition()
		@div.appendTo container
		circumference = 2 * Math.PI * @radius
		increments = circumference / rate
		@angleIncrement = 360 / increments

	calculatePosition: ->
		@y = @center.y - @radius * Math.sin @angle
		@x = @center.x + @radius * Math.cos @angle

	setPosition: ->
		@calculatePosition()
		@div.css
			left: @px @x
			top: @px @y

	stepForward: ->
		@angle += @angleIncrement
		@setPosition()
		if @crossedOrigin()
			@updateColor()
			@playSound()

	crossedOrigin: ->
		if @angle > TWO_PI
			@angle -= TWO_PI
			return true
		false

	updateColor: ->

	playSound: ->

	px: (pos) ->
		"#{pos}px"

$ ->
	body = $ document.body
	canvas = $ "<canvas width='#{window.innerWidth-17}' height='#{window.innerHeight-17}'>"
	body.append canvas
	canvas.css
		border: "1px solid black"

	canvas = canvas[0]
	context = canvas.getContext("2d");
	
	# context.fillRect 10, 10, 55, 50
	context.beginPath()
	context.arc 100, 100, 5, 0, TWO_PI, false
	context.fillStyle = "#555555"
	context.fill()
	context.stroke()

	# interval = .05
	# center =
	# 	y: window.innerHeight / 2
	# 	x: window.innerWidth / 2

	# new Dot 0, center, 5, body
	# dots = []
	
	# for i in [1 .. 30]
	# 	radius = 15 * i
	# 	dots.push new Dot radius, center, interval, body, TWO_PI
	# 	dots.push new Dot radius, center, interval, body, HALF_PI
	# 	dots.push new Dot radius, center, interval, body, PI
	# 	dots.push new Dot radius, center, interval, body, THREE_HALFS_PI

	# intervalFn = ->
	# 	dot.stepForward() for dot in dots

	# window.setInterval intervalFn, 10
		
	# new Dot 50, center, pi / 2, body
	# new Dot 50, center, pi, body
	# new Dot 50, center, 3 * pi / 2, body