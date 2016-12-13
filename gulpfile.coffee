gulp              = require 'gulp'
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
buildRoot =       './build'
deployRoot =      './public'


build= 
  client: 
    js:           "#{buildRoot}/js"
    css:          "#{buildRoot}/css"
    fonts:        "#{buildRoot}/fonts"
    vendor:       "#{buildRoot}/bower_components"

deploy=
  client:
    js:         "#{deployRoot}/js"
    css:        "#{deployRoot}/css"
    fonts:      "#{deployRoot}/fonts"
    vendor:     "#{deployRoot}/bower_components"

src =
  client:         './src/client'
  server:         './src/server'

srcGLOB=
  client:         './src/client/**/*.coffee'
  server:         './src/server/**/*.coffee'

        

# this will run in THIS ORDER
# build-clean
# copy tasks cpy* will run in parallel
# compile task compile* will run in parallel
gulp.task "build", (callback) ->
  runSequence "build-clean", [
    "cpyrequire"
    "cpycomponents"    
    "cpytemplates"
    "cpystatic"
    "cpymock"
    "cpyfonts"
    "cpyselect2"
  ], [
    "compile-less"
    "compile-coffee-client"
    "compile-coffee-server"
  ], callback
  #return

# CLEAN TASK 
# delete build folders for client and server projects
gulp.task "build-clean",  ->
  gulp.src [buildRoot, deployRoot], read:false
    .pipe clean force: true
  


# COPY TASKS
gulp.task 'copystatic', ->
  task=gulp.src './bower_components/requirejs/require.js'  
    .pipe uglify()
    .pipe gulp.dest deployRoot 
  task.on 'error', (err)->
    console.warn "copy static:#{err.message}"
  task
  task=gulp.src './index.html'  
    .pipe gulp.dest deployRoot 
  task.on 'error', (err)->
    console.warn "copy static: #{err.message}"
  task


gulp.task 'copyfonts', ->
  task=gulp.src ['./bower_components/bootstrap/fonts/**/*', './bower_components/bootstrap-material-design/fonts/**/*']
    .pipe gulp.dest deploy.client.fonts 
  task.on 'error', (err)->
    console.warn "cpyfonts:", err.message
  task

gulp.task 'deploycss', ['compile-less'],->
  task =gulp.src  "#{build.client.css}/**/*"
    .pipe gulp.dest deploy.client.css
  task



gulp.task 'deployjs', ['compile-coffee-client'], ->
  task=gulp.src "#{build.client.js}/**/*"
    .pipe gulp.dest deploy.client.js
  task.on 'error', (err)->
    console.warn "deployjs:", err.message
  task

gulp.task 'deployhtm', ['cpytemplates'], ->
  task=gulp.src "#{build.client.js}/**/*.htm"
    .pipe gulp.dest deploy.client.js
  task.on 'error', (err)->
    console.warn "deployjs:", err.message
  task



gulp.task 'copytemplates', ->
  #templates GLOB
  task = gulp.src "#{src.client}/**/*.htm"
    .pipe gulp.dest build.client.js
  task.on 'error', (err)->
    console.warn "cpytemplates:", err.message
  task


# COMPILE TASKS
# less to css + minifyCSS
gulp.task 'compile-less', ->
  task = gulp.src "#{src.client}/styles/main.less"
    .pipe less()
    .pipe minifyCSS()
    .pipe gulp.dest build.client.css
  task.on 'error', (err)->
    console.warn "compile-less:", err.message
  task


gulp.task 'compile-coffee-server', ->
  # bare true for server/nodejs modules
  task = gulp.src srcGLOB.server
    .pipe coffee bare: true
    .pipe gulp.dest build.server
  task.on 'error', (err)->
    console.warn "compile-coffee-server:", err.message
  task

gulp.task 'compile-coffee-client', ->
  # bare false for AMD client modules wraps modules
  task = gulp.src srcGLOB.client
    .pipe coffeelint()  
    .pipe coffee bare: false  
    # wrap js modules
    .pipe gulp.dest build.client.js
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
