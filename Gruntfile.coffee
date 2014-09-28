module.exports = (grunt) ->
    pkg: grunt.file.readJSON 'package.json'
    grunt.initConfig {
        coffee: {
            compile: {
                files: [
                    {
                        expand: true
                        cwd: 'src/coffee/'
                        src: '*.coffee'
                        dest: 'src/js/'
                        ext: '.js'
                    }
                ]
            }
        }
        
        watch: {
            gruntfile: {
                files: 'Gruntfile.coffee'
                tasks: 'default'
            }
            coffee: {
                files: ['src/coffee/*.coffee']
                tasks: ['default']
            }
        }
    }

    grunt.loadNpmTasks 'grunt-contrib-coffee'
    grunt.loadNpmTasks 'grunt-contrib-watch'

    grunt.registerTask 'default', ['coffee']
