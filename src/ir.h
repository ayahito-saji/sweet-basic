#ifndef _IR_H_
#define _IR_H_
  #include "ast.h"

  enum irtype { IR_ADD };

  struct irline {
    enum irtype type;
    unsigned int argc;
    unsigned int line;
    struct irline *prev;
    struct irline *next;
  };

  struct irline *ast2ir(struct astnode *node);

#endif // _IR_H_
