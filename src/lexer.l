%{
#include <stdio.h>
#include "y.tab.h"
#include "ast.h"

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
  yylval.node = astnode_num(temp);
  return LITERAL;
}
[0-9]*\.[0-9]* {
  double temp;
  sscanf(yytext, "%lf", &temp);
  yylval.node = astnode_num(temp);
  return LITERAL;
}
%%
