var gulp = require('gulp');
var uglify = require('gulp-uglify');
var csso = require('gulp-csso');
var rename = require("gulp-rename");
var htmlmin = require('gulp-htmlmin');
var less = require("gulp-less");
var del = require('del');
var gm = require('gulp-gm');
var imagemin = require('gulp-imagemin');
var jade = require('gulp-jade');
var toJson = require('gulp-to-json');
var marked = require('marked');

gulp.task('image',function(){
	return gulp.src("resources/img/*")
		.pipe(imagemin({}))
        .pipe(gulp.dest('assets/img'));
});



gulp.task('less',function(){
	return gulp.src('resources/css/*.less')
		.pipe(less())
		.pipe(csso())
		.pipe(gulp.dest('assets/css'))
});

gulp.task('jade',function(){
	return gulp.src('templates/*.jade')
		.pipe(jade({
			markdown:marked
		}))
		.pipe(gulp.dest('./'))
})


gulp.task('default',function(){
	gulp.watch('resources/css/*.less',['less'])
	gulp.watch('templates/md/*',['jade'])
 	gulp.watch('templates/*.jade',['jade'])
})
