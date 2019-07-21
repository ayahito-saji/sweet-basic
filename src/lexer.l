%{
#include <stdio.h>
#include "y.tab.h"
#include "node.h"

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
  yylval.node = num(temp);
  return LITERAL;
}
[0-9]*\.[0-9]* {
  double temp;
  sscanf(yytext, "%lf", &temp);
  yylval.node = num(temp);
  return LITERAL;
}
%%
