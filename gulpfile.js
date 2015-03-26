var gulp = require('gulp')
//var nodemon = require('gulp-nodemon')
var coffee = require('gulp-iced-coffee');
var sourcemaps = require('gulp-sourcemaps');
var nib = require('nib'); // register compiler with node
var coffeelint = require('gulp-coffeelint')
var mocha = require('gulp-mocha');
var stylus = require('gulp-stylus');
var server = require('gulp-develop-server');
var bower = require('main-bower-files');
var concat = require('gulp-concat');
var concatCss = require('gulp-concat-css');
var sequence = require('run-sequence');
var clean = require('gulp-clean');
var uglify = require('gulp-uglify');
var minifyCss = require('gulp-minify-css');
var gutil = require('gulp-util');

require('iced-coffee-script/register'); // register compiler with node

var paths = {
  app: ['./app/**/*.coffee'],
  style: ['./app/**/*.styl'],
  test: ['./tests/**/*.coffee']
};

// Get *.styl file and render 
gulp.task('styles', function () {
  gulp.src(paths.style)
    .pipe(stylus({use: [nib()]}))
    .pipe(concatCss("bundle.css"))
    .pipe(minifyCss({keepBreaks:true}))
    .pipe(gulp.dest('./public/css/'));
});

// *.js
gulp.task('bower', function() {
  return gulp.src(bower())
    .pipe(concat('vendor.js'))
    .pipe(uglify())
    .pipe(gulp.dest('./public/js'));
});

/*
gulp.task('compile', function() {
  gulp.src(paths.app)
    .pipe(sourcemaps.init())
    .pipe(coffee({bare: true}).on('error', gutil.log))
    .pipe(sourcemaps.write())
    .pipe(concat('app.js'))
    .pipe(uglify())
    .pipe(gulp.dest('./public/'))
});
*/

gulp.task('lint', function () {
  gulp.src(paths.app)
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
  gulp.watch(paths.app, ['lint', 'server'])
  gulp.watch(paths.style, ['styles'])
  gulp.watch(paths.tests, ['test'])
});

// run server 
gulp.task( 'server', function() {
  server.listen( { path: './server.js' } );
});

/*
gulp.task('demon', function () {
  nodemon({
    script: 'server.js',
    ext: 'html js coffee',
    ignore: ['ignored.js'],
    nodeArgs: [''] , // not nodemon args
    env: {'NODE_ENV': 'development'}
  })
    //.on('change', ['watch'])
    .on('restart', function () {
      console.log('restarted!')
    })
})
*/

gulp.task('clean', function() {
    gulp.src('./public/*').pipe(clean());
});

gulp.task('build', function(callback) {
  sequence('clean',
           ['bower', 'styles'],
           callback);
});

// The default task (called when you run `gulp` from cli) 
gulp.task('default', ['lint', 'build', 'watch', 'server']);