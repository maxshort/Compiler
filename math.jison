

%lex

%%
\d+ return "NUMERIC_LITERAL"
\s+ /*Ignore whitespace*/
\+  return "PLUS_SIGN"
<<EOF>> return "EOF"
. return "INVALID"

/lex

%start EXPR

%%
EXPR: ADD_EXPR 1 {console.log($1); return $1}; /*No idea why the 1 has to be here...*/
ADD_EXPR: NUMERIC_LITERAL PLUS_SIGN NUMERIC_LITERAL {{$$={
	type:'ADD_EXPR',
	arguments:[$1, $2, $3]};};}
	;