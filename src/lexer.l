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
  struct node *p = (struct node*) malloc((int) sizeof(struct node));
  p->type = 'n';
  p->num = (int) (temp * (1 << 12));
  yylval.node = p;
  return LITERAL;
}
[0-9]*\.[0-9]* {
  double temp;
  sscanf(yytext, "%lf", &temp);
  struct node *p = (struct node*) malloc((int) sizeof(struct node));
  p->type = 'n';
  p->num = (int) (temp * (1 << 12));
  yylval.node = p;
  return LITERAL;
}
%%
