module.exports = (grunt) ->
    grunt.initConfig {
        pkg: grunt.file.readJSON 'package.json'

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
                    'src/js/zhaopin.js': ['src/coffee/zhaopin.coffee', 'src/coffee/utils.coffee'],
                    'src/js/51job.js': ['src/coffee/51job.coffee', 'src/coffee/utils.coffee']
                }
            }
        }

        copy: {
            main: {
                files: [
                    {expand: true, cwd: 'src/', src: ['*'], dest: 'dist/', filter: 'isFile'},
                ]
            },
            js: {
                files: [
                    {expand: true, cwd: 'src/js/', src: ['*.js'], dest: 'dist/js/', ext: '.js'}
                ]
            },
            lib: {
                files: {
                    'dist/lib/jquery.min.js': 'src/lib/jquery/dist/jquery.min.js'
                }
            }
        },

        compress: {
            main: {
                options: {
                    archive: '<%= pkg.name %>.zip'
                },
                files: [
                    {expand: true, cwd: 'dist/', src: ['**'], dest: ''}
                ]
            }
        },
        
        watch: {
            gruntfile: {
                files: 'Gruntfile.coffee'
                tasks: 'default'
            }
            coffee: {
                files: ['src/coffee/*.coffee']
                tasks: ['default', 'copy']
            }
        }
    }

    grunt.loadNpmTasks 'grunt-contrib-coffee'
    grunt.loadNpmTasks 'grunt-contrib-copy'
    grunt.loadNpmTasks 'grunt-contrib-compress'
    grunt.loadNpmTasks 'grunt-contrib-watch'

    grunt.registerTask 'dist', ['coffee', 'copy', 'compress', 'compress']
    grunt.registerTask 'default', ['coffee', 'copy', 'compress']
