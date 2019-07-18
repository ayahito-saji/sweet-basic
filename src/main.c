#include <stdio.h>
#include "./y.tab.h"

int main(int argc, char **argv) {
  if (argc == 1) {
    printf("Sweet BASIC v0.0.1\n");
    return 0;
  }

  FILE *fp;
  int chr;
  fp = fopen(argv[1], "r");
  if (fp == NULL) {
    printf("Load failed\n");
    return 1;
  }

  extern int yyparse(void);
  extern FILE *yyin;
  yyin = fp;
  if (yyparse()) {
    printf("SyntaxError\n");
  }

  fclose(fp);

  return 0;
}
