gulp              = require 'gulp'
#gulpif            = require 'gulp-if'
watch             = require 'gulp-watch'
runSequence       = require 'run-sequence'
gutil             = require 'gulp-util'
coffee            = require 'gulp-coffee'
coffeelint        = require 'gulp-coffeelint'
less              = require 'gulp-less'
autoprefixer      = require 'gulp-autoprefixer'
clean             = require 'gulp-rimraf'
uglify            = require 'gulp-uglify'
minifyCSS         = require 'gulp-minify-css'
rjs               = require 'gulp-requirejs'
#async             = require 'async'




# config
isDevelopment = ->
  return true if process.env.NODE_ENV is "development"
  return false 

target = ->
  return "./lib" if isDevelopment()
  return "./public" 


root = 
  client: 
    js:           "#{target()}/js"
    css:          "#{target()}/css"
    fonts:        "#{target()}/fonts"
    vendor:       "#{target()}/bower_components"


gulp.task 'set-dev-env', ->
  process.env.NODE_ENV = 'development'


gulp.task 'set-prod-env', -> 
  process.env.NODE_ENV = 'production'


gulp.task 'dev', ['set-dev-env'], (callback)-> 
  runSequence "build-clean", [
    "copystatic"
    "copyassets"
    "copytemplates"
    "copyfonts"
    'copyvendor'
  ], [
    "compile-coffee-client"
    "compile-less"
  ], callback
  


gulp.task 'prod', ['set-prod-env'],  () ->
      # your code




src =
  client:         './src/client'
  server:         './src/server'

srcGLOB=
  client:         './src/client/**/*.coffee'
  server:         './src/server/**/*.coffee'

        

# CLEAN TASK 
# delete build folders for client and server projects
gulp.task "build-clean",  ->
  gulp.src ['./lib', './public'], read:false
    .pipe clean force: true
  
gulp.task "clean-src-js",  ->
  gulp.src "#{src.client}/**/*.js", read:false
    .pipe clean force: true


# COPY TASKS
gulp.task 'copystatic', ->
  task=gulp.src './bower_components/requirejs/require.js'  
    .pipe uglify()
    .pipe gulp.dest root.client.js 
  task.on 'error', (err)->
    console.warn "copy static:#{err.message}"
  task

gulp.task 'copyassets', ->
  task=gulp.src './src/wwwroot/index.html'  
    .pipe gulp.dest './public'
  task.on 'error', (err)->
    console.warn "copy assets: #{err.message}"
  task

gulp.task 'copyvendor', ->
  task=gulp.src './bower_components/**/*'  
    .pipe gulp.dest root.client.vendor
  task.on 'error', (err)->
    console.warn "copy assets: #{err.message}"
  task



gulp.task 'copyfonts', ->
  task=gulp.src ['./bower_components/bootstrap/fonts/**/*', './bower_components/bootstrap-material-design/fonts/**/*']
    .pipe gulp.dest root.client.fonts 
  task.on 'error', (err)->
    console.warn "cpyfonts:", err.message
  task




gulp.task 'copytemplates', ->
  #templates GLOB
  task = gulp.src "#{src.client}/**/*.htm"
    .pipe gulp.dest root.client.js
  task.on 'error', (err)->
    console.warn "copytemplates:", err.message
  task


# COMPILE TASKS
# less to css + minifyCSS
gulp.task 'compile-less', ->
  task = gulp.src "./src/styles/main.less"
    .pipe less()
    .pipe minifyCSS()
    .pipe gulp.dest root.client.css
  task.on 'error', (err)->
    console.warn "compile-less:", err.message
  task



gulp.task 'compile-coffee-client', ->
  # bare false for AMD client modules wraps modules
  task = gulp.src srcGLOB.client
    .pipe coffeelint()  
    .pipe coffee bare: false  
    # wrap js modules
    .pipe gulp.dest root.client.js
  task.on 'error', (err)->
    console.warn "compile-coffee-client:", err.message
  task

    
# deploy and watch
gulp.task "deploy-dev", (callback)->
  runSequence 'deploy', [
    'deployjs'
    'deploycomponents'
  ], callback

gulp.task "deploy-dev-watch", ['deploy-dev'] ,->
  gutil.log "=> WATCHING..."
  watcher = gulp.watch(srcGLOB.client, ['deployjs'])
  watcher.on 'change', (event) ->
    console.log "File: " + event.path + ": " + event.type + "=>COFFEE cli"

  swatcher = gulp.watch(srcGLOB.server, ['compile-coffee-server'])
  swatcher.on 'change', (event) ->
    console.log "File: " + event.path + ": " + event.type + "=>COFFEE srv"

  twatcher = gulp.watch("#{src.client}/**/*.htm", ['deployhtm'])
  twatcher.on 'change', (event) ->
    console.log "File: " + event.path + ": " + event.type + "=>CPY tmpl"

  lwatcher = gulp.watch("#{src.client}/styles/**/*.less", ['deploycss'])
  lwatcher.on 'change', (event) ->
    console.log "File: " + event.path + ": " + event.type + "=>COMILE LESS"


# production deployment (note will have PUSH to development server also)
gulp.task 'deploy-prod', ['deploy'], ->
  rjs
    baseUrl:          "./build/js"
    mainConfigFile:   "./build/js/main.js"
    out: "main.js"
    include: 'main'

    inlineText: true
    useStrict: false
    #optimize: 'uglify2'
    skipPragmas: false
    
    skipModuleInsertion: false
    stubModules: ['text']
    optimizeAllPluginResources: false
    findNestedDependencies: false
    removeCombined: false
    fileExclusionRegExp: /^\./
    preserveLicenseComments: true
    logLevel: 0
  .pipe uglify()
  .pipe gulp.dest deploy.client.js



gulp.task "deploy", (callback) ->
  runSequence "build", [
    "deploystatic"
    "deployfonts"
    "deploycss"    
    "deployrequire"
  ], callback
