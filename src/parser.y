%{
#include <stdio.h>
#include <stdlib.h>
#define YYDEBUG 1
#include "ast.h"

extern unsigned int astline;
extern struct astnode *root;

%}
%union {
  struct astnode *node;
}
%token <node> LITERAL
%token <node> '+' '-' '*' '/' CR '(' ')' ':'
%type <node> program statements statement instruction expression term primary_expression
%%
program
    : statements { $$ = astnode_new(PROGRAM); astnode_add($$, $1); root = $$; }
    ;

statements
    : { $$ = astnode_new(STATEMENTS); }
    | statements statement CR { astnode_add($1, $2); astline ++; }
    ;
statement
    : instruction { $$ = astnode_new(STATEMENT); astnode_add($$, $1);}
    | statement ':' instruction { astnode_add($1, $3); }
    ;
instruction
    : { $$ = NULL; }
    | expression
    ;
expression
    : term
    | '-' term { $$ = astnode_new(SUB); astnode_add($$, astnode_num(0.0)); astnode_add($$, $2); }
    | expression '+' term { $$ = astnode_new(ADD); astnode_add($$, $1); astnode_add($$, $3); }
    | expression '-' term { $$ = astnode_new(SUB); astnode_add($$, $1); astnode_add($$, $3);}
    ;
term
    : primary_expression
    | term '*' primary_expression { $$ = astnode_new(MUL); astnode_add($$, $1); astnode_add($$, $3); }
    | term '/' primary_expression { $$ = astnode_new(DIV); astnode_add($$, $1); astnode_add($$, $3); }
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
