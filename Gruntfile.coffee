module.exports = (grunt) ->
    grunt.initConfig {
        pkg: grunt.file.readJSON 'package.json'

        coffee: {
            compile: {
                options: {
                    join: true
                }
                
                files: {
                    'dist/js/background.js': 'src/coffee/background.coffee',
                    'dist/js/options.js': 'src/coffee/options.coffee',
                    'dist/js/58.js': ['src/coffee/58.coffee', 'src/coffee/utils.coffee'],
                    'dist/js/ganji.js': ['src/coffee/ganji.coffee', 'src/coffee/utils.coffee'],
                    'dist/js/zhaopin.js': ['src/coffee/zhaopin.coffee', 'src/coffee/utils.coffee'],
                    'dist/js/51job.js': ['src/coffee/51job.coffee', 'src/coffee/utils.coffee']
                }
            }
        }

        copy: {
            main: {
                files: [
                    {expand: true, cwd: 'src/', src: ['*'], dest: 'dist/', filter: 'isFile'},
                ]
            }

            lib: {
                files: {
                    'dist/lib/jquery.min.js': 'src/lib/jquery/dist/jquery.min.js',
                    'dist/lib/jquery.min.map': 'src/lib/jquery/dist/jquery.min.map',
                }
            }
        }

        compress: {
            main: {
                options: {
                    archive: '<%= pkg.name %>.zip'
                }

                files: [
                    {expand: true, cwd: 'dist/', src: ['**'], dest: ''}
                ]
            }
        }
        
        watch: {
            gruntfile: {
                files: 'Gruntfile.coffee'
                tasks: ['coffee', 'copy']
            }

            main: {
                files: ['src/*']
                tasks: ['copy:main']
            }

            coffee: {
                files: ['src/coffee/*.coffee']
                tasks: ['coffee']
            }

            lib: {
                files: ['src/lib/**']
                tasks: ['copy:lib']
            }
        }
    }

    grunt.loadNpmTasks 'grunt-contrib-coffee'
    grunt.loadNpmTasks 'grunt-contrib-copy'
    grunt.loadNpmTasks 'grunt-contrib-compress'
    grunt.loadNpmTasks 'grunt-contrib-watch'

    grunt.registerTask 'default', ['coffee', 'copy', 'compress']
