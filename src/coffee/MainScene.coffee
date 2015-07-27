class MainScene

	constructor: ->
		@init()

	init: =>
		@$container = $("#container")

		@camera = new THREE.PerspectiveCamera 60, window.innerWidth / window.innerHeight, 1, 10000
		@camera.position.z = 500

		@controls = new THREE.OrbitControls @camera
		@controls.damping = 0.2;

		@scene = new THREE.Scene()

		@light = new THREE.DirectionalLight 0xffffff, 1
		@light.position.set(1, 1, 1).normalize()
		@scene.add @light

		geometry = new THREE.BoxGeometry 20, 20, 20
		for i in [0...2000]
			obj = new THREE.Mesh geometry, new THREE.MeshLambertMaterial({color: Math.random() * 0xffffff})

			obj.position.x = Math.random() * 800 - 400
			obj.position.y = Math.random() * 800 - 400
			obj.position.z = Math.random() * 800 - 400

			obj.rotation.x = Math.random() * 2 * Math.PI
			obj.rotation.y = Math.random() * 2 * Math.PI
			obj.rotation.z = Math.random() * 2 * Math.PI

			obj.scale.x = Math.random() + .5
			obj.scale.y = Math.random() + .5
			obj.scale.z = Math.random() + .5

			@scene.add obj

		@renderer = new THREE.WebGLRenderer()
		@renderer.setClearColor 0xf0f0f0
		@renderer.setPixelRatio window.devicePixelRatio
		@renderer.setSize window.innerWidth, window.innerHeight
		@renderer.sortObjects = false
		@$container.append @renderer.domElement

		$(window).on "resize", @onResize

		rAFManager.add @animate

	onResize: (event) =>
		@camera.aspect = window.innerWidth / window.innerHeight
		@camera.updateProjectionMatrix()

		@renderer.setSize window.innerWidth, window.innerHeight

	animate: =>
		@controls.update()
		@render()

	render: =>
		@renderer.render @scene, @camera