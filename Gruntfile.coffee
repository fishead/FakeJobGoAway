module.exports = (grunt) ->
    pkg: grunt.file.readJSON 'package.json'
    grunt.initConfig {
        coffee: {
            compile: {
                options: {
                    join: true
                },
                files: {
                        'src/js/background.js': 'src/coffee/background.coffee',
                        'src/js/options.js': 'src/coffee/options.coffee',
                        'src/js/58.js': ['src/coffee/58.coffee', 'src/coffee/utils.coffee'],
                        'src/js/ganji.js': ['src/coffee/ganji.coffee', 'src/coffee/utils.coffee'],
                        'src/js/zhaopin.js': ['src/coffee/zhaopin.coffee', 'src/coffee/utils.coffee']
                }
            },
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
