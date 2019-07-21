#ifndef _NODE_H_
#define _NODE_H_
  struct node {
    char type;
    int num;
    char str[256];
    struct node *left;
    struct node *right;
  } *root;


  struct node *tree(char type, struct node *left, struct node *right);
  struct node *num(double val);
  void viewTree (struct node *tree, int indent);

#endif // _NODE_H_
