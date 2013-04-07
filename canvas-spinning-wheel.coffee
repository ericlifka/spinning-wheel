PI = Math.PI
TWO_PI = 2 * Math.PI
HALF_PI = Math.PI / 2
THREEHALVES_PI = 3 * Math.PI / 2

class SoundDot
	constructor: (@radius, @center, @angle=HALF_PI, @rate=.05) ->
		@circumference = TWO_PI * @radius
		@centerY = @center.y
		@centerX = @center.x

	calculatePosition: ->
		@y = @centerY - @radius * Math.sin @angle
		@x = @centerX + @radius * Math.cos @angle

	update: (ellapsedTime) ->
		# console.log 'updating'
		dist = @rate * ellapsedTime
		angle = TWO_PI * dist / @circumference
		@angle += angle
		@calculatePosition()

	render: (graphics) ->
		# console.log 'rendering', @x, @y
		graphics.beginPath()
		graphics.arc @x, @y, 5, 0, TWO_PI, false
		graphics.fillStyle = "#555555"
		graphics.fill()
		graphics.stroke()


class World
	constructor: (@width, @height) ->
		@dots = []

	initialize: ->
		center =
			x: @width / 2
			y: @height / 2

		for i in [1..10]
			radius = 20 * i
			@dots.push new SoundDot radius, center, 0
			@dots.push new SoundDot radius, center, HALF_PI
			@dots.push new SoundDot radius, center, PI
			@dots.push new SoundDot radius, center, THREEHALVES_PI

	update: (ellapsedTime) ->
		dot.update(ellapsedTime) for dot in @dots

	render: (graphics) ->
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

	window.setInterval update, 10
		# break
