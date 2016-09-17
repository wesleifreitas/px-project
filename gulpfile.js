var gulp = require('gulp');
var gutil = require('gulp-util');
var jshint = require('gulp-jshint');
var uglify = require('gulp-uglify');
var cssmin = require('gulp-cssmin');
var rename = require('gulp-rename');
var replace = require('gulp-replace');
var watch = require('gulp-watch');

gulp.task('build-js', function() {
	return gulp
		.src(['./src/js/*.js'])
		//.pipe(uglify())
		.pipe(gulp.dest('dist/js'));
});

gulp.task('jshint-js', function() {
	return gulp
		.src(['./src/js/*.js'])
		.pipe(jshint())
		.pipe(jshint.reporter('default'));
});

gulp.task('build-system-js', function() {
	return gulp
		.src(['./src/system/**/*.js'])
		.pipe(uglify())
		//.pipe(rename({
		//	suffix: '.min'
		//}))
		.pipe(gulp.dest('dist/system'));
});

gulp.task('jshint-system', function() {
	return gulp
		.src(['./src/system/**/*.js'])
		.pipe(jshint())
		.pipe(jshint.reporter('default'))
		.pipe(uglify())
		//.pipe(rename({
		//	suffix: '.min'
		//}))
		.pipe(gulp.dest('dist/system'));
});

gulp.task('build-system-css', function() {
	return gulp
		.src(['./src/system/**/*.css'])
		.pipe(cssmin())
		//.pipe(rename({
		//	suffix: '.min'
		//}))
		.pipe(gulp.dest('dist/system'));
});

gulp.task('build-system-others', function() {
	return gulp
		.src([
			'./src/system/**/*.html',
			'./src/system/**/*.woff',
			'./src/system/**/*.ttf',
			'./src/system/**/*.cfm',
			'./src/system/**/*.cfc',
			'./src/system/**/*.cfc',
			'./src/system/**/*.gif',
			'./src/system/**/*.png'
		])		
		.pipe(gulp.dest('dist/system'));
});

gulp.task('build-assets', function() {
	return gulp
		.src([			
			'./src/system/assets/richsolutions/*.jpg'
		])		
		.pipe(gulp.dest('dist/system/assets/richsolutions'));
});

gulp.task('build-rest', function() {
	return gulp
		.src([
			'./src/rest/**/*.*'
		])
		.pipe(gulp.dest('dist/rest'));
});

gulp.task('watch', function() {
	gulp.watch('src/js/**/*.js', ['build-js']);
	gulp.watch('./src/system/**/*.js', ['build-system-js']);	
	gulp.watch('./src/system/**/*.css', ['build-system-css']);
	gulp.watch('./src/system/**/*.*', ['build-system-others']);
	gulp.watch('./src/system/assets/richsolutions/*.jpg', ['build-assets']);
});

gulp.task('default', [
	'build-js',
	'build-system-js',	
	'build-system-css',
	'build-system-others',
	'build-assets',
	'build-rest'
]);