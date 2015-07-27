module.exports = (grunt) ->

	require("matchdep").filterDev("grunt-*").forEach(grunt.loadNpmTasks)

	srcPath = "src/"
	distPath = "dist/"

	grunt.initConfig
		clean:
			css: [
				distPath + "css/*"
			]
			js: [
				distPath + "js/*"
			]

		coffee:
			dev:
				options:
					bare: true
					sourceMap: true
				files: [
					expand: true
					cwd: srcPath + "coffee/"
					src: ['**/*.coffee']
					dest: distPath + "js/"
					ext: ".js"
				]

		compass:
			desktop:
				options:
					config: "config.rb"

		browserSync:
			bsFiles:
				src : [
					distPath + "css/**"
					distPath + "js/**"
					distPath + "index.html"
				]
			options:
				watchTask: true
				server:
            		baseDir: distPath

		watch:
			options:
				spawn: false
			coffee:
				files: [srcPath + "coffee/**/*.coffee"]
				tasks: ["coffee"]
			sass:
				files: [srcPath + "scss/**/*.scss"]
				tasks: ["compass"]

	grunt.registerTask "default", ["clean", "compass", "coffee", "browserSync", "watch"]
