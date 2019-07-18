%{
#include <stdio.h>
#include "y.tab.h"

int yywrap(void) {
  return 1;
}
%}
%%
"+"   return '+';
"-"   return '-';
"*"   return '*';
"/"   return '/';
"\n"  return CR;
"("   return '(';
")"   return ')';
[1-9][0-9]* {
  double temp;
  sscanf(yytext, "%lf", &temp);
  yylval.double_value = temp;
  return DOUBLE_LITERAL;
}
[0-9]*\.[0-9]* {
  double temp;
  sscanf(yytext, "%lf", &temp);
  yylval.double_value = temp;
  return DOUBLE_LITERAL;
}
%%
