%{
#include "parser.tab.h"
#include <string.h>
%}

%%
"int"           { return INT; }
[a-zA-Z_][a-zA-Z0-9_]*   { yylval.str = strdup(yytext); return ID; }
[0-9]+          { yylval.num = atoi(yytext); return NUM; }
"="             { return ASSIGN; }
";"             { return SEMI; }
"("             { return LPAREN; }
")"             { return RPAREN; }
"+"             { return PLUS; }
"-"             { return MINUS; }
"*"             { return MUL; }
"/"             { return DIV; }
[ \t\n\r]+      ; // skip whitespace
.               { printf("Invalid character: %s\n", yytext); }

%%
int yywrap() { return 1; }
