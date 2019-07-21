#include "ast.h"
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <math.h>

struct astnode *root;

struct astnode *astnode_tree(char type, struct astnode *left, struct astnode *right) {
  struct astnode *p = (struct astnode*) malloc((int) sizeof(struct astnode));
  p->type = type;
  p->left = left;
  p->right = right;
  root = p;
  return p;
}

struct astnode *astnode_num(double val) {
  struct astnode *p = (struct astnode*) malloc((int) sizeof(struct astnode));
  p->type = 'n';
  p->num = (int) (val * (1 << 12));
  root = p;
  return p;
}

void view_ast (struct astnode *tree, int indent) {
  if (tree->left) view_ast(tree->left, indent + 2);

  if (tree->type == 'n') {
    char c, str[256];
    int i, len;
    sprintf(str, "%.3f", round(tree->num / (4.096))/1000.0);
    len = strlen(str);
    for (i=len-1; i>=0; i--) {
      c = *(str + i);
      if (c == '0') { *(str + i) = '\0'; }
      else if (c == '.') { *(str + i) = '\0';break; }
      else { break; }
    }
    printf("%*s%s\n", indent, "", str);
  }
  else
    printf("%*s%c\n", indent, "", tree->type);

  if (tree->right) view_ast(tree->right, indent + 2);
}
