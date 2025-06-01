%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "symbol_table.h"
#include "codegen.h"

int yylex();
void yyerror(const char *s);
%}

%union {
    int num;
    char *str;
}

%token <num> NUM
%token <str> ID
%token INT ASSIGN SEMI PLUS MINUS MUL DIV LPAREN RPAREN
%type <num> expr

%%

program:
    program stmt
    | stmt
    ;

stmt:
    INT ID SEMI
    {
        add_symbol($2);
        free($2);
    }
    |
    ID ASSIGN expr SEMI
    {
        if (!lookup_symbol($1)) {
            printf("Undeclared variable %s\n", $1);
            exit(1);
        }
        generate_assignment($1, $3);
        free($1);
    }
    ;

expr:
    expr PLUS expr { $$ = generate_temp("ADD", $1, $3); }
    | expr MINUS expr { $$ = generate_temp("SUB", $1, $3); }
    | expr MUL expr { $$ = generate_temp("MUL", $1, $3); }
    | expr DIV expr { $$ = generate_temp("DIV", $1, $3); }
    | NUM { $$ = $1; }
    | ID {
        if (!lookup_symbol($1)) {
            printf("Undeclared variable %s\n", $1);
            exit(1);
        }
        $$ = get_var($1);
    }
    | LPAREN expr RPAREN { $$ = $2; }
    ;

%%

void yyerror(const char *s) {
    printf("Parse error: %s\n", s);
}
