%{
#include <stdio.h>
#include <stdlib.h>
#define YYDEBUG 1
#include "node.h"

%}
%union {
  struct node *node;
}
%token <node> LITERAL
%token <node> '+' '-' '*' '/' CR '(' ')'
%type <node> statements statement expression term primary_expression
%%
statements
    : statement
    | statements statement { $$ = tree('s', $1, $2); }
    ;
statement
    : expression CR
    ;
expression
    : term
    | '-' term { $$ = tree('-', num(0.0), $2); }
    | expression '+' term { $$ = tree('+', $1, $3); }
    | expression '-' term { $$ = tree('-', $1, $3); }
    ;
term
    : primary_expression
    | term '*' primary_expression { $$ = tree('*', $1, $3); }
    | term '/' primary_expression { $$ = tree('/', $1, $3); }
    ;
primary_expression
    : LITERAL
    | '(' expression ')' { $$ = $2; }
    ;
%%
int yyerror(char const *str) {
  extern char *yytext;
  // fprintf(stderr, "parser errpr near %s\n", yytext);
  return 0;
}
