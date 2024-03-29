%{
#include <stdio.h>
#include "y.tab.h"
#include "ast.h"

int yywrap(void) {
  return 1;
}
%}
%%
[ \t\r] {}
"+" { return '+'; }
"-" { return '-'; }
"*" { return '*'; }
"/" { return '/'; }
"\n" { return CR; }
"(" { return '('; }
")" { return ')'; }
"," { return ','; }
":" { return ':'; }
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
\"[^\"]*\" {
  yylval.node = astnode_str(yytext);
  return LITERAL;
}
[_a-zA-Z][_a-zA-Z0-9]* {
  yylval.node = astnode_sbl(yytext);
  return IDENTIFIER;
}
%%
