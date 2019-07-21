%{
#include <stdio.h>
#include <stdlib.h>
#define YYDEBUG 1
#include "ast.h"

unsigned int astline = 1;

%}
%union {
  struct astnode *node;
}
%token <node> LITERAL
%token <node> '+' '-' '*' '/' CR '(' ')' ':'
%type <node> statements statement expression term primary_expression
%%
statements
    : statement CR { astline ++; }
    | statement ':'
    | statements statement CR { $$ = astnode_tree(STATEMENTS, $1, $2); astline ++; }
    | statements statement ':' { $$ = astnode_tree(STATEMENTS, $1, $2); }
    ;
statement
    : expression
    | { $$ = NULL; }
    ;
expression
    : term
    | '-' term { $$ = astnode_tree(SUB, astnode_num(0.0), $2); }
    | expression '+' term { $$ = astnode_tree(ADD, $1, $3); }
    | expression '-' term { $$ = astnode_tree(SUB, $1, $3); }
    ;
term
    : primary_expression
    | term '*' primary_expression { $$ = astnode_tree(MUL, $1, $3); }
    | term '/' primary_expression { $$ = astnode_tree(DIV, $1, $3); }
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
