%{
#include <stdio.h>
#include <stdlib.h>
#define YYDEBUG 1
#include "ast.h"

%}
%union {
  struct astnode *node;
}
%token <node> LITERAL
%token <node> '+' '-' '*' '/' CR '(' ')'
%type <node> statements statement expression term primary_expression
%%
statements
    : statement
    | statements statement { $$ = astnode_tree('s', $1, $2); }
    ;
statement
    : expression CR
    ;
expression
    : term
    | '-' term { $$ = astnode_tree('-', astnode_num(0.0), $2); }
    | expression '+' term { $$ = astnode_tree('+', $1, $3); }
    | expression '-' term { $$ = astnode_tree('-', $1, $3); }
    ;
term
    : primary_expression
    | term '*' primary_expression { $$ = astnode_tree('*', $1, $3); }
    | term '/' primary_expression { $$ = astnode_tree('/', $1, $3); }
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
