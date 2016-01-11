/**
 * Gulpfile for hampusn-message-cache
 */

var assetsDirs = ['./public/assets'];

var project = require('./package.json'),
    gulp = require('gulp'),
    sass = require('gulp-sass'),
    uglify = require('gulp-uglify'),
    watch = require('gulp-watch'),
    concat = require('gulp-concat'),
    replace = require('gulp-replace'),
    notifier = require('node-notifier'),
    normalize = require('node-normalize-scss'),
    bourbon = require('node-bourbon');


/**
 * Logger callback for styles task
 * @param  {object} err The error object
 */
var stylesLogger = function (err) {
  var msg = err.line + ':' + err.column + ': ' + err.file + '\n';
      msg += err.message.split("\n")[0];

  console.log(msg);
  notifier.notify({
    'title': 'SASS ERROR',
    'message': msg,
    'sound': 'Ping',
    'time': 8000
  });
}


/**
 * Gulp task for styles
 */
var stylesTask = function (path) {
  // Current time. Will be used to set timestamp on
  // compiled css.
  var now = new Date().toString();

  var srcs = [
    path + '/src/sass/**/*.scss'
  ];

  var dest = path + '/build/css/';

  gulp.src(srcs)
    .pipe(sass({
      'includePaths': ['styles'].concat(bourbon.includePaths, normalize.includePaths),
      'errLogToConsole': false,
      'onError': stylesLogger
    }))
    .pipe(replace('{{version}}', project.version))
    .pipe(replace('{{timestamp}}', now))
    .pipe(gulp.dest(dest));
};


/**
 * Logger callback for script task
 * @param  {error} err The error object
 */
var scriptsLogger = function (err) {
  var msg = err.lineNumber + ': ' + err.fileName + '\n';
  msg += err.message.split(':')[1];

  console.log(msg);
  notifier.notify({
    'title': 'JS ERROR',
    'message': msg,
    'sound': 'Ping',
    'time': 8000
  });
}


/**
 * Gulp task for scripts
 */
var scriptsTask = function (path) {
  var now = new Date().toString();

  // Select all vendors, modules and also main.js lastly.
  // The order is important since it's the order that they
  // will be put together in.
  var srcs = [
    path + '/src/js/vendors/*.js',
    path + '/src/js/modules/*.js',
    path + '/src/js/main.js'
  ];

  var dest = path + '/build/js/';

  gulp.src(srcs)
    .pipe(uglify({
      'preserveComments': 'some'
    }))
    .on('error', scriptsLogger)
    // Merge all selected files into new file: main.js
    // and place it in assets build folder.
    .pipe(concat('main.js', { 'newLine': '\r\n\r\n' }))
    .pipe(replace('{{version}}', project.version))
    .pipe(replace('{{timestamp}}', now))
    .pipe(gulp.dest(dest));
};


// Styles
gulp.task('sass', function() {
  for (var i = assetsDirs.length - 1; i >= 0; i--) {
    stylesTask(assetsDirs[i]);
  };
});


// Javascript
gulp.task('js', function() {
  for (var i = assetsDirs.length - 1; i >= 0; i--) {
    scriptsTask(assetsDirs[i]);
  };
});


// Watch
gulp.task('watch', function() {
  var stylesSrcs = [];
  var scriptsSrcs = [];

  for (var i = assetsDirs.length - 1; i >= 0; i--) {
    stylesSrcs.push(assetsDirs[i] + '/src/sass/**/*.scss');
    scriptsSrcs.push(assetsDirs[i] + '/src/js/**/*.js');
  }

  // watch style files
  gulp.watch(stylesSrcs, ['sass']);
  // Watch script files
  gulp.watch(scriptsSrcs, ['js']);
});

gulp.task('default', ['sass', 'js', 'watch']);
