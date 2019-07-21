#include "ast.h"
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <math.h>

struct astnode *root;

struct astnode *astnode_tree(enum asttype type, struct astnode *left, struct astnode *right) {
  struct astnode *p = (struct astnode*) malloc((int) sizeof(struct astnode));
  p->type = type;
  p->left = left;
  p->right = right;
  root = p;
  return p;
}

struct astnode *astnode_num(double val) {
  struct astnode *p = (struct astnode*) malloc((int) sizeof(struct astnode));
  p->type = NUMBER;
  p->num = (int) (val * (1 << 12));
  root = p;
  return p;
}

void view_ast (struct astnode *tree, int indent) {
  char c, str[256];
  int i, len;

  if (tree->left) view_ast(tree->left, indent + 2);

  printf("%*s", indent, "");
  switch (tree->type) {
    case NUMBER:
      sprintf(str, "%.3f", round(tree->num / (4.096))/1000.0);
      len = strlen(str);
      for (i=len-1; i>=0; i--) {
        c = *(str + i);
        if (c == '0') { *(str + i) = '\0'; }
        else if (c == '.') { *(str + i) = '\0';break; }
        else { break; }
      }
      printf("%s\n", str);
      break;
    case ADD:
      printf("+\n");
      break;
    case SUB:
      printf("-\n");
      break;
    case MUL:
      printf("*\n");
      break;
    case DIV:
      printf("/\n");
      break;
    case STATEMENTS:
      printf(":\n");
      break;
  }

  if (tree->right) view_ast(tree->right, indent + 2);
}
