%{
#include <stdio.h>
#include "y.tab.h"

int yywrap(void) {
  return 1;
}
%}
%%
"+" { return '+'; }
"-" { return '-'; }
"*" { return '*'; }
"/" { return '/'; }
"\n" { return CR; }
"(" { return '('; }
")" { return ')'; }
[0-9]+ {
  double temp;
  sscanf(yytext, "%lf", &temp);
  yylval.number_value = (int) (temp * (1 << 12));
  return NUMBER_LITERAL;
}
[0-9]*\.[0-9]* {
  double temp;
  sscanf(yytext, "%lf", &temp);
  yylval.number_value = (int) (temp * (1 << 12));
  return NUMBER_LITERAL;
}
%%
