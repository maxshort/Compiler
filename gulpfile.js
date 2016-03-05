var gulp = require("gulp");
var merge = require("merge-stream");
var shell = require('gulp-shell');


gulp.task('build', ['makeParser']);

gulp.task('makeParser', ['flattenFiles'],
	shell.task(['jison parseInfo.jison -o parser.js'], {cwd:'build'})
);

gulp.task('flattenFiles', function() {
	var llvmStuff = gulp.src('llvm.js/*.js');
	var myPage = gulp.src('index.html');
	var myJison = gulp.src('parseInfo.jison');
	
	return merge(llvmStuff, myPage, myJison)
	.pipe(gulp.dest('build'));
});