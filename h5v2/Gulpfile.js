var gulp = require('gulp');
var uglify = require('gulp-uglify');
var csso = require('gulp-csso');
var rename = require("gulp-rename");
var htmlmin = require('gulp-htmlmin');
// var less = require("gulp-less");
var del = require('del');
var gm = require('gulp-gm');
var imagemin = require('gulp-imagemin');
var jade = require('gulp-jade');
var toJson = require('gulp-to-json');


gulp.task('tojson',function(){
   	return gulp.src('slides_min/*.jpg').pipe(toJson({
   		relative:true
    }));
})


gulp.task('image',function(){
	return gulp.src("slides/*.jpg")
		.pipe(imagemin({
			progressive:true
		}))
        .pipe(gulp.dest('./slides_min'));
});


gulp.task('html',function(){
	var slides = require('./output.json')
	return gulp.src('./templates/index.jade')
    	.pipe(jade({
	      	data:{
	      		slides:slides
	      	},
   		 }))
    	.pipe(gulp.dest('./'));
})

