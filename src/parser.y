%{
#include <stdio.h>
#include <stdlib.h>
#define YYDEBUG 1
#include "node.h"

struct node *tree(char type, struct node *left, struct node *right) {
  struct node *p = (struct node*) malloc((int) sizeof(struct node));
  p->type = type;
  p->left = left;
  p->right = right;
  root = p;
  return p;
}

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
    ;
%%
int yyerror(char const *str) {
  extern char *yytext;
  // fprintf(stderr, "parser errpr near %s\n", yytext);
  return 0;
}
