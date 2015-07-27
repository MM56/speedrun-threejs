class App

	constructor: ->
		@init()

	init: =>
		FunctionStats.init()
		rAFManager.init()

	start: =>
		@scene = new MainScene()

app = new App()
app.start()