#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <math.h>
#include "ast.h"
#include "ir.h"
#include "y.tab.h"
#define VERSION "0.0.1"

int debug = 0;

int main(int argc, char **argv) {
  char *fileName;

  int i;
  char option;
  for(i=1;i<argc;i++){
    if (*argv[i] == '-') {
      option = *(argv[i]+1);
      if (option == 'v' || strcmp(argv[i], "--version")==0) {
        printf("SWEET BASIC v%s\n", VERSION);
        exit(0);
      } else if (option == 'h' || strcmp(argv[i], "--help")==0) {
        printf("SWEET BASIC v%s\n", VERSION);
        printf("\n");
        printf("Arguments:\n");
        printf("  -h or --help         Print Help message and exit\n");
        printf("  -v or --version      Print version information and exit\n");
        printf("  -d or --debug        Run in debug mode\n");
        exit(0);
      } else if (option == 'd' || strcmp(argv[i], "--debug")==0) {
        debug = 1;
      }
    } else {
      fileName = argv[i];
    }
  }

  if (debug) printf("DEBUG MODE: %d\n", debug);


  FILE *fp;
  int chr;
  fp = fopen(fileName, "r");
  if (fp == NULL) {
    printf("Load failed\n");
    return 1;
  }

  extern int yyparse(void);
  extern FILE *yyin;

  yyin = fp;
  if (yyparse()) {
    extern unsigned int astline;
    printf("Syntax error(%d)\n", astline);
    exit(1);
  }
  fclose(fp);

  extern struct astnode *root;
  // printf("ルート:%p\n", root);
  if (!root) exit(1);

  if (debug) {
    printf("- Done syntax parse\n");
    view_ast(root, 0);
  }

  struct irline *ir = ast2ir(root);

  return 0;
}
