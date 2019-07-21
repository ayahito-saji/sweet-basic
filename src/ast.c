#include "ast.h"
#include "y.tab.h"
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <math.h>

struct astnode *root;

struct astnode *astnode_tree(enum asttype type, struct astnode *left, struct astnode *right) {
  if (left == NULL && right == NULL) return NULL;
  if (left != NULL && right == NULL) return left;
  if (left == NULL && right != NULL) return right;

  extern unsigned int astline;

  struct astnode *p = (struct astnode*) malloc((int) sizeof(struct astnode));
  p->type = type;
  p->left = left;
  p->right = right;
  p->line = astline;
  root = p;
  return p;
}

struct astnode *astnode_num(double val) {
  extern unsigned int astline;
  if (val <= 524287 && val >= -524287) {
    struct astnode *p = (struct astnode*) malloc((int) sizeof(struct astnode));
    p->type = NUMBER;
    p->num = (int) (val * (1 << 12));
    p->line = astline;
    root = p;
    return p;
  } else {
    printf("Overflow(%d)\n", astline);
    exit(1);
  }
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
      printf("%s(%d)\n", str, tree->line);
      break;
    case ADD:
      printf("+(%d)\n", tree->line);
      break;
    case SUB:
      printf("-(%d)\n", tree->line);
      break;
    case MUL:
      printf("*(%d)\n", tree->line);
      break;
    case DIV:
      printf("/(%d)\n", tree->line);
      break;
    case STATEMENTS:
      printf(":\n");
      break;
  }

  if (tree->right) view_ast(tree->right, indent + 2);
}
