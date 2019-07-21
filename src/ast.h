#ifndef _AST_H_
#define _AST_H_
  struct astnode {
    char type;
    int num;
    char str[256];
    struct astnode *left;
    struct astnode *right;
  } *root;

  struct astnode *astnode_tree(char type, struct astnode *left, struct astnode *right);
  struct astnode *astnode_num(double val);
  void viewTree (struct astnode *tree, int indent);

#endif // _AST_H_
