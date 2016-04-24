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

LET_STMT: "let" EQ_STMT_GRP "in" EXPR {$$ = $2;}
;

EQ_STMT_GRP: EQ_STMT EQ_STMT_GRP {$$ = shallowMerge($1, $2);}
			| EQ_STMT {$$ = $1;}
;

EQ_STMT: ID "=" EXPR {sylList = {}; sylList[$1] = $3; $$ = sylList;}
;

/*EXPRS: EXPR EOF {console.log($1); return $1;}
;*/

EXPR: '(' EXPR ')' {$$= $2;}
	| EXPR '+' EXPR {$$= $1 + $3;}
	| EXPR '-' EXPR {$$= $1 - $3;}
	| EXPR '*' EXPR {$$= $1 * $3;}
	| EXPR '/' EXPR {$$= $1 / $3;}
	| NUMERIC_LITERAL {$$= +($1);} 
	;
%%
function shallowMerge(x, y) {
		temp = Object.assign({}, x);
		return Object.assign(temp, y);
}