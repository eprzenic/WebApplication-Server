var gulp = require('gulp')
var coffee = require('gulp-coffee'); // ice not needed
var sourcemaps = require('gulp-sourcemaps');
var nib = require('nib'); // register compiler with node
var coffeelint = require('gulp-coffeelint')
var mocha = require('gulp-mocha');
var stylus = require('gulp-stylus');
var server = require('gulp-develop-server');
var bower = require('main-bower-files');
var concat = require('gulp-concat');
var concatCss = require('gulp-concat-css');
var del = require('del');
var uglify = require('gulp-uglify');
var minifyCss = require('gulp-minify-css');
var gutil = require('gulp-util');

require('coffee-script/register'); // register compiler with node

var paths = {
  app: ['./app/**/*'],
  style: ['./app/**/*.styl'],
  test: ['./tests/**/*.coffee']
};

// *.js
gulp.task('bower', function() {
  return gulp.src(bower())
    .pipe(concat('vendor.js'))
    .pipe(uglify())
    .pipe(gulp.dest('./dist/js'));
});

gulp.task('styles', function () {
  gulp.src(paths.style)
    .pipe(stylus({use: [nib()]}))
    .pipe(concatCss("bundle.css"))
    .pipe(minifyCss({keepBreaks:true}))
    .pipe(gulp.dest('./dist/css/'));
});

gulp.task('compile', function() {
  gulp.src('./app/views/**/*.coffee')
//    .pipe(sourcemaps.init())
    .pipe(coffee({bare: true}).on('error', gutil.log))
//    .pipe(sourcemaps.write())
    .pipe(concat('app.js'))
    .pipe(uglify())
    .pipe(gulp.dest('./dist/js'))
});


gulp.task('lint', function () {
  gulp.src(paths.app+'./app/**/*.coffee')
    .pipe(coffeelint())
    .pipe(coffeelint.reporter())
});

gulp.task('test', function () {
  return gulp
    .src(paths.test, {read: false})
    .pipe(mocha({
      report: 'nyan',
      istanbul: true, // code coverage
      globals: {
        should: require('chai')
      },
      env: {
        'NODE_ENV': 'test'
      }
    }));
});

// Rerun the task when a file changes 
gulp.task('watch', function() {
  gulp.watch(paths.app, ['default', 'restart'])
  gulp.watch(paths.app, server.restart)
  gulp.watch(paths.tests, ['test'])
});

// run server 
gulp.task('run', function() {
  server.listen( { path: './server.js' } );
});

// restart server
gulp.task('restart', ['default'], function() {
  server.restart()
});

gulp.task('clean', function (cb) {
  del(['./dist/**/*'], cb);
});

gulp.task('copy', function() {
  gulp.src(['./public/**/*']).pipe(gulp.dest('./dist'));
});

// view/client only
gulp.task('client', ['clean', 'bower', 'styles', 'copy', 'compile']);
// server only
gulp.task('server', ['lint', 'test', 'watch', 'run']);

gulp.task('default', ['client','server']);