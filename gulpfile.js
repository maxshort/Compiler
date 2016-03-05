var fs = require('fs');
var gulp = require("gulp");
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
	var llvmStuff = gulp.src('llvm.js/*.js');
	var myPage = gulp.src('index.html');
	var myJison = gulp.src('parseInfo.jison');
	
	return merge(llvmStuff, myPage, myJison)
	.pipe(gulp.dest('build'));
});