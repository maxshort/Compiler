

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

. return "INVALID"

/lex

%left '*' '/'
%left '+' '-'


%start EXPRS

%%
EXPRS: EXPR EOF {console.log($1); return $1;}
;

EXPR: '(' EXPR ')' {console.log("IN EXPR:" + $2); $$= $2;}
	| EXPR '+' EXPR {$$= $1 + $3;}
	| EXPR '-' EXPR {$$= $1 - $3;}
	| EXPR '*' EXPR {$$= $1 * $3;}
	| EXPR '/' EXPR {$$= $1 / $3;}
	| NUMERIC_LITERAL {$$= +($1);} 
	;
