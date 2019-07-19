%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#define YYDEBUG 1

%}
%union {
  int number_value;
}
%token <number_value> NUMBER_LITERAL
%token '+' '-' '*' '/' CR '(' ')'
%type <number_value> expression term primary_expression
%%
line_list
    : line
    | line_list line
    ;
line
    : expression CR {
      char c, str[256];
      int i, len;
      sprintf(str, "%.3f", round($1 / (4.096))/1000.0);
      len = strlen(str);
      for (i=len-1; i>=0; i--) {
        c = *(str + i);
        if (c == '0') { *(str + i) = '\0'; }
        else if (c == '.') { *(str + i) = '\0';break; }
        else { break; }
      }
      printf("%s\n", str);
    }
    ;
expression
    : term
    | expression '+' term { $$ = $1 + $3; }
    | expression '-' term { $$ = $1 - $3; }
    | '-' term { $$ = -$2; }
    ;
term
    : primary_expression
    | term '*' primary_expression { $$ = (($1 * $3) >> 12); }
    | term '/' primary_expression { $$ = (($1 / $3) >> 12); }
    ;
primary_expression
    : NUMBER_LITERAL
    | '(' expression ')' { $$ = $2; }
    ;
%%
int yyerror(char const *str) {
  extern char *yytext;
  // fprintf(stderr, "parser errpr near %s\n", yytext);
  return 0;
}
