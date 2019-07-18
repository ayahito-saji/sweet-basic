%{
#include <stdio.h>
#include <stdlib.h>
#define YYDEBUG 1
%}
%union {
  int int_value;
  double double_value;
}
%token <double_value> DOUBLE_LITERAL
%token '+' '-' '*' '/' CR '(' ')'
%type <double_value> expression term primary_expression
%%
line_list
    : line
    | line_list line
    ;
line
    : expression CR { printf("%d\n", (int) $1); }
    ;
expression
    : term
    | expression '+' term { $$ = $1 + $3; }
    | expression '-' term { $$ = $1 - $3; }
    | '-' term { $$ = -$2; }
    ;
term
    : primary_expression
    | term '*' primary_expression { $$ = $1 * $3; }
    | term '/' primary_expression { $$ = $1 / $3; }
    ;
primary_expression
    : DOUBLE_LITERAL
    | '(' expression ')' { $$ = $2; }
    ;
%%
int yyerror(char const *str) {
  extern char *yytext;
  // fprintf(stderr, "parser errpr near %s\n", yytext);
  return 0;
}
