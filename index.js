var llvm = require("./llvm.js/llvm-as.js");
var math = require("./math.js");
var compiler = require("./llvm.js/compiler.js");
//console.log(math);
//console.log(math.Parser);
console.log("LLVM:");
console.log(llvm);
function parseAndRun() {
	var pTree = math.parse(document.getElementById("progInput").value);
	console.log(compiler.compile(genAssembly(pTree)));
}

function genAssembly(parseTree) {
	return ('target triple = "i386-pc-linux-gnu"\n'+

'@.prf = private constant [4 x i8] c"%i\0A\00"\n'+


'define i32 @main() {\n'+
'entry:\n'+
  '%str1 = getelementptr inbounds [4 x i8]* @.prf, i32 0, i32 0\n'+
  '%0 = add i32 ' + parseTree.arguments[0] + ',' + parseTree.arguments[2] + '\n'+
  '%acall = call i32 (i8*,...)* @printf(i8* %str1, i32 %0)\n'+
  'ret i32 1\n'+
'}\n'+

'declare i32 @printf(i8*, ...)\n');
};

var goButton = document.getElementById("goButton");
goButton.addEventListener("click", parseAndRun);