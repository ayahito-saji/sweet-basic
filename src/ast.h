#ifndef _AST_H_
#define _AST_H_

  enum asttype { NUMBER, STRING, SYMBOL, ADD, SUB, MUL, DIV, ARGUMENTS, INSTRUCTION, STATEMENT, STATEMENTS, PROGRAM };

  struct astnode {
    enum asttype type;
    int num;
    char* str;
    struct astnode *child;
    struct astnode *next;
    unsigned int line;
  } *root;

  struct astnode *astnode_new(enum asttype type);
  void astnode_add(struct astnode *parent, struct astnode *node);
  struct astnode *astnode_num(double val);
  struct astnode *astnode_str(char *val);
  struct astnode *astnode_sbl(char *val);
  void view_ast (struct astnode *tree, int indent);

#endif // _AST_H_
