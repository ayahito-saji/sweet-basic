#ifndef _AST_H_
#define _AST_H_

  enum asttype { NUMBER, ADD, SUB, MUL, DIV, STATEMENTS, PROGRAM };

  struct astnode {
    enum asttype type;
    int num;
    char str[256];
    struct astnode *left;
    struct astnode *right;
  } *root;

  struct astnode *astnode_tree(enum asttype type, struct astnode *left, struct astnode *right);
  struct astnode *astnode_num(double val);
  void view_ast (struct astnode *tree, int indent);

#endif // _AST_H_
