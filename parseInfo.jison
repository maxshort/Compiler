

%lex

%%
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
PRGRM: EQ_STMT EOF {return $1;}
;

EQ_STMT: ID "=" EXPR {sylList = {}; sylList[$1] = $3; $$ = sylList;}
;

/*EXPRS: EXPR EOF {console.log($1); return $1;}
;*/

EXPR: '(' EXPR ')' {console.log("IN EXPR:" + $2); $$= $2;}
	| EXPR '+' EXPR {$$= $1 + $3;}
	| EXPR '-' EXPR {$$= $1 - $3;}
	| EXPR '*' EXPR {$$= $1 * $3;}
	| EXPR '/' EXPR {$$= $1 / $3;}
	| NUMERIC_LITERAL {$$= +($1);} 
	;
