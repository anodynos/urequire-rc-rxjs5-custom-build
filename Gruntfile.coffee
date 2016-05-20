module.exports = (grunt) ->
  gruntConfig =
    urequire:
      _all:
        clean: true
        template:
          name: 'nodejs'
          banner: true
        bare: true
        runtimeInfo: false
        debugLevel: 0
        #verbose:true

      build:
        path: 'source/code'
        dstPath: 'build/code'
        resources: [
          ['babeljs', {
              plugins: ['add-module-exports'],
              presets: ['es2015', 'es2015-loose', 'stage-0'] }],

          'inject-version'
        ]

      devBuild:
        derive: ['build']
        watch: 'grunt-urequire'

  for shortCut, tasks of {
    default: ["urequire:build"]    # spec
    dev:     ["urequire:devBuild"] # specWatch
  }
    grunt.registerTask shortCut, tasks

  grunt.loadNpmTasks 'grunt-urequire'
  grunt.initConfig gruntConfig
