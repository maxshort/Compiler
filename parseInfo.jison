%{/*var funcs = {
	shallowMerge:function shallowMerge(x, y) {
		alert(1 + JSON.Stringify(x));
		alert(2 + JSON.Stringify(y));
		temp = Object.assign({}, x);
		return Object.assign(temp, y);
	}
	}*/
%}


%lex

%%
//Lex goes in order so keywords have to go first
"let" {return "let";}
"in" {return "in"} //
\d+ {return "NUMERIC_LITERAL";}
\s+ /*Ignore whitespace*/
<<EOF>> {return "EOF";}
'+' {return "+";}
"-" {return "-";}
"*" {return "*";}
"/" {return "/";}
"(" {return "(";}
")" {return ")";}
[a-zA-Z][a-zA-z0-9_']* {return "ID";}
"=" {return "=";}


. return "INVALID"

/lex

%left '*' '/'
%left '+' '-'


%start PRGRM

%%
PRGRM: LET_STMT EOF {return $1; }
	| EXPR EOF {return $1; }
;

LET_STMT: "let" EQ_STMT_GRP "in" EXPR {$$ = {baseNode:$4, context:$2 };}
;

EQ_STMT_GRP: EQ_STMT EQ_STMT_GRP {$$ = shallowMerge($1, $2);}
			| EQ_STMT {$$ = $1;}
;

EQ_STMT: ID "=" EXPR {sylList = {}; sylList[$1] = $3; $$ = sylList;}
;

/*EXPRS: EXPR EOF {return $1;}
;*/

EXPR: '(' EXPR ')' {$$= $2;}
	| EXPR '+' EXPR {$$= new Node(add, $1, $3);}
	| EXPR '-' EXPR {$$= new Node(sub, $1, $3);}
	| EXPR '*' EXPR {$$= new Node(mul, $1, $3);}
	| EXPR '/' EXPR {$$= new Node(div, $1, $3);}
	| NUMERIC_LITERAL {$$= new Node(+($1));} 
	| ID {$$ = new Node($1)}
	;
%%
function shallowMerge(x, y) {
		var xProps = Object.getOwnPropertyNames(x);
		var yProps = Object.getOwnPropertyNames(y);
		var expectedSize = xProps.length + yProps.length;
		var temp = Object.assign({}, x);
		var combined = Object.assign(temp, y);
		var combinedProps = Object.getOwnPropertyNames(combined);
		if (expectedSize > combinedProps.length) { //there was a duplicate so set < sum of individual sizes
			dup = xProps.find(function findADup(currentX) {
				return y[currentX] !==undefined;
			});
			throw {message: "Duplicate identifier: " + dup}
		}
		return combined;
}

//value could be a literal value or an operation to combine l and r (which should be literal values...
function Node(val, l, r) {
	if (val == null) {
		throw {message: "A Node must have a value"}
	}
	this.left = l;
	this.right = r;
	this.value = val;
}

function add(x, y) {return x + y;}
function sub(x, y) {return x - y;}
function mul(x, y) {return x * y;}
function div(x, y) {return x / y;}