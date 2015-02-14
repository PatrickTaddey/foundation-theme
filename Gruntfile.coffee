module.exports = (grunt) ->

	grunt.initConfig
		pkg: grunt.file.readJSON("package.json")

		browserify:
			app:
				src: ["src/dev/scripts/**/*.coffee"]
				dest: "src/build/scripts/app.js"
				options:
					extensions: [".coffee"]
					transform: ["coffeeify", "debowerify"]
					watch: true

		sass:
			build:
				options:
					sourcemap: true
				files:
					"src/build/stylesheets/app.css": "src/dev/stylesheets/app.scss"

		connect:
			build:
				options:
					livereload: true
					port: 9000
					base: "src/build"

		clean: ["src/build"]

		copy:
			build:
				files: [
					{expand: true, cwd: "src/dev/vendor/components-font-awesome/fonts/", src: ["**"], dest: "src/build/fonts"}
					{expand: true, cwd: "src/dev/images/", src: ["**"], dest: "src/build/images"}
				]

		watch:
			build_html:
				files: [
					"./index.html"
				]
				tasks: []
				options:
					livereload: true
			build_js:
				files: [
					"src/build/scripts/app.js"
				]
				tasks: []
				options:
					livereload: true
			build_css:
				files: [
					"src/dev/**/*.scss"
				]
				tasks: ["sass:build"]
				options:
					livereload: true

		focus:
			build:
				include: ["build_html", "build_js", "build_css"]

		require('load-grunt-tasks')(grunt)

		grunt.registerTask "default", [
			"clean",
			"browserify:app",
			"sass:build",
			"copy:build",
			"connect:build",
			"focus:build"
		]