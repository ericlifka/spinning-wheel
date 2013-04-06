PI = Math.PI
TWO_PI = Math.PI * 2
HALF_PI = Math.PI / 2

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
	pi = Math.PI
	interval = .05
	center =
		y: window.innerHeight / 2
		x: window.innerWidth / 2

	new Dot 0, center, 5, body
	dots = []
	
	for i in [1 .. 30]
		radius = 15 * i
		dots.push new Dot radius, center, interval, body, 0
		dots.push new Dot radius, center, interval, body, Math.PI / 2
		dots.push new Dot radius, center, interval, body, Math.PI
		dots.push new Dot radius, center, interval, body, Math.PI * 3 / 2

	intervalFn = ->
		dot.stepForward() for dot in dots

	window.setInterval intervalFn, 10
		
	# new Dot 50, center, pi / 2, body
	# new Dot 50, center, pi, body
	# new Dot 50, center, 3 * pi / 2, body