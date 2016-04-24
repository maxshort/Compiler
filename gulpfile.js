var fs = require('fs');
var gulp = require("gulp");
var htmlhint = require("gulp-htmlhint");
var jshint = require("gulp-jshint");
var merge = require("merge-stream");
var shell = require('gulp-shell');
var GulpSSH = require('gulp-ssh');

gulp.task("pushOnSuccess", ['build'], function() {
	try {
		var rawCreds = fs.readFileSync("./cred.json", "utf-8");
		var creds = JSON.parse(rawCreds);
		var gulpSSH = new GulpSSH({
			ignoreErrors:false,
			sshConfig:creds
		});
		
		return gulp.src("./build/*")
		.pipe(gulpSSH.dest("./public_html/compiler"));
	}
	catch(e) {
		throw "Error reading credentials: " + e;
	}
});

gulp.task('build', ['makeParser']);

gulp.task('makeParser', ['flattenFiles'],
	shell.task(['jison parseInfo.jison -o parser.js'], {cwd:'build'})
);

gulp.task('flattenFiles', function() {
	var myPage = gulp.src('index.html')
		.pipe(jshint.reporter("fail"))
		.pipe(htmlhint.failReporter());
		
	var myJison = gulp.src('parseInfo.jison');
	
	return merge(myPage, myJison)
	.pipe(gulp.dest('build'));
});