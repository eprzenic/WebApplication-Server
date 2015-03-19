var gulp = require('gulp')
//var nodemon = require('gulp-nodemon')
var iced = require('gulp-iced-coffee');
var sourcemaps = require('gulp-sourcemaps');
var nib = require('nib'); // register compiler with node
var coffeelint = require('gulp-coffeelint')
var mocha = require('gulp-mocha');
var stylus = require('gulp-stylus');
var server = require('gulp-develop-server');

require('iced-coffee-script/register'); // register compiler with node

var paths = {
  app: ['app/**/*.coffee'],
  style: ['app/**/*.styl'],
  test: ['test/**/*']
};

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

// Get *.styl file and render 
gulp.task('style', function () {
  gulp.src(paths.style)
    .pipe(stylus({use: [nib()]}))
    .pipe(gulp.dest('./public/css/'))
});

/*
gulp.task('compile', function() {
  gulp.src(paths.app)
  .pipe(sourcemaps.init())
  .pipe(iced({bare: true}))
  .pipe(sourcemaps.write())
  .pipe(gulp.dest('./public/'))
});
*/

// Rerun the task when a file changes 
gulp.task('watch', function() {
  gulp.watch(paths.app, ['lint', 'server'])
  gulp.watch(paths.style, ['style'])
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

// The default task (called when you run `gulp` from cli) 
gulp.task('default', ['lint', 'style', 'watch', 'server']);