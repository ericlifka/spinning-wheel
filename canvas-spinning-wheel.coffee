PI = Math.PI
TWO_PI = 2 * Math.PI
HALF_PI = Math.PI / 2
THREEHALVES_PI = 3 * Math.PI / 2

MOZIAC_RATE = .614

class SoundDot
	constructor: (@radius, @center, @angle=HALF_PI, @rate=.2) ->
		@START_ANGLE = @angle
		@circumference = TWO_PI * @radius
		@centerY = @center.y
		@centerX = @center.x
		@color =
			red: 0
			green: 0
			blue: 0

	calculatePosition: ->
		@y = @centerY - @radius * Math.sin @angle
		@x = @centerX + @radius * Math.cos @angle

	update: (ellapsedTime) ->
		dist = @rate * ellapsedTime
		angle = TWO_PI * dist / @circumference
		@angle += angle
		@calculatePosition()

		colorChange = angle / TWO_PI * 255
		@color.blue += colorChange

		if @checkWrapAround()
			@color.blue = 0
			@color.green += 16
			if @color.green > 255
				@color.green = 0
				@color.red += 16
				if @color.red > 255
					@color.red = 0

	checkWrapAround: ->
		if @angle > @START_ANGLE
			@angle -= TWO_PI
			true
		else
			false

	render: (graphics) ->
		color = "rgb(#{@color.red}, #{@color.green}, #{Math.floor(@color.blue)})"

		graphics.beginPath()
		graphics.fillStyle = color
		# graphics.fillStyle = "#ffffff"
		graphics.strokeStyle = color
		graphics.arc @x, @y, 3, 0, TWO_PI, false
		graphics.fill()
		graphics.stroke()
		graphics.closePath()

	playSound: ->


class World
	constructor: (@width, @height) ->
		@dots = []

	initialize: ->
		center =
			x: @width / 2
			y: @height / 2

		for i in [1..100]
			radius = 5 * i
			@dots.push new SoundDot radius, center, 0
			@dots.push new SoundDot radius, center, TWO_PI / 3
			@dots.push new SoundDot radius, center, TWO_PI / 3 * 2
			@dots.push new SoundDot radius, center, 0 + TWO_PI / 6
			@dots.push new SoundDot radius, center, TWO_PI / 3 + TWO_PI / 6
			@dots.push new SoundDot radius, center, TWO_PI / 3 * 2 + TWO_PI / 6

			# @dots.push new SoundDot radius, center, THREEHALVES_PI

	update: (ellapsedTime) ->
		dot.update(ellapsedTime) for dot in @dots

	render: (graphics) ->
		graphics.strokeStyle = "#000000"
		dot.render(graphics) for dot in @dots

$ ->
	width = window.innerWidth-17
	height = window.innerHeight-17

	$("<canvas width='#{width}' height='#{height}'>").appendTo document.body
	$('canvas').css {border: "1px solid black"}
	canvas = $('canvas')[0]

	context = canvas.getContext "2d"
	clearContext = (context) ->
		context.save()
		context.setTransform 1, 0, 0, 1, 0, 0
		context.clearRect 0, 0, width, height
		context.restore()

	world = new World width, height
	world.initialize()

	prevTime = new Date()

	update = ->
		currentTime = new Date()
		ellapsedTime = currentTime - prevTime
		prevTime = currentTime

		world.update ellapsedTime
		clearContext context
		world.render context

	window.setInterval update, 33
